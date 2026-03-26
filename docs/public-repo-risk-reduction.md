# Public Repo Risk Reduction Guide

This repository does **not** currently expose raw secrets in the tracked files I checked, but its public history does reveal some personal metadata:

- personal email addresses in commit history
- a work email address in commit history
- a machine-generated `.local` email/hostname in commit history
- older absolute paths such as `/Users/archer.chang/...` in historical config versions

That means the main risk here is **privacy leakage**, not an active credential leak.

## 1. Stop leaking identity in future commits

Do this first. It prevents new commits from adding more personal metadata.

1. In GitHub, open **Settings -> Emails**.
2. Turn on **Keep my email addresses private**.
3. Turn on the setting that blocks command-line pushes which expose your personal email, if your account shows it.
4. Copy the GitHub-provided noreply email shown on that page.

Then set Git to use that noreply identity by default:

```bash
git config --global user.name "archer0302"
git config --global user.email "<your GitHub noreply email>"
git config --global user.useConfigOnly true
```

Why `user.useConfigOnly` matters: it prevents Git from inventing a fallback identity from your machine settings, which is how `.local` host-based addresses often show up.

Verify the result:

```bash
git config --global --get user.name
git config --global --get user.email
git config --global --get user.useConfigOnly
git log -1 --format='%an <%ae>'
```

If you need a different identity for work repositories, override it **inside those repos only**:

```bash
cd /path/to/work-repo
git config user.name "Archer Chang"
git config user.email "archer.chang@wisetechglobal.com"
```

That keeps your default public identity private while still allowing a work identity where appropriate.

## 2. Move machine-specific settings into ignored local files

Keep tracked files portable. Move anything specific to one machine into a local override file that is ignored by Git.

Good candidates for local-only files:

- absolute file paths
- background image paths
- corporate endpoints or internal hostnames
- usernames or home-directory-specific values
- tokens, API keys, and credentials
- debugger tool paths installed in a user-specific location

Suggested local-only files for this repo:

- `wezterm/local.lua`
- `nvim/lua/config/local.lua`

Ignore them:

```bash
printf '\nwezterm/local.lua\nnvim/lua/config/local.lua\n.env\n.env.local\n' >> .gitignore
```

Guideline:

- keep the repo version as the safe default
- load the local override only if the file exists
- never commit the local override file

This is the cleanest way to keep public dotfiles portable without exposing local paths or credentials.

## 3. Make sure local junk never becomes tracked

This repo already ignores `.DS_Store`, but it is worth protecting yourself globally too:

```bash
git config --global core.excludesfile ~/.gitignore_global
printf ".DS_Store\n" >> ~/.gitignore_global
```

If a local file ever becomes tracked by mistake, untrack it without deleting your local copy:

```bash
git rm --cached --ignore-unmatch .DS_Store
git rm --cached --ignore-unmatch .env .env.local
```

Then commit the cleanup.

## 4. Start fresh with a new remote repo

If you are okay abandoning the old Git history, this is usually the simplest cleanup path.

This gives you:

- a clean commit history starting from one safe initial commit
- no legacy author emails in the new repository
- no legacy machine-specific paths in the new repository history

Important: this does **not** clean the old public repo by itself. If the old repo stays public, its old history stays public too. To actually reduce exposure, move to the new repo and then retire the old one.

### 4.1 Choose what you want to copy

There are two safe ways to create the new repo content:

- copy the **current working tree** if you want your uncommitted changes too
- export **HEAD only** if you want just the latest committed state

If you want the current working tree, create a new directory without the old `.git` history:

```bash
cd ..
rsync -a --exclude '.git' dot-configs/ dot-configs-public/
cd dot-configs-public
```

If you want only the last committed snapshot instead:

```bash
mkdir ../dot-configs-public
git archive --format=tar HEAD | (cd ../dot-configs-public && tar xf -)
cd ../dot-configs-public
```

### 4.2 Clean the snapshot before publishing

Before creating the new repo, remove obvious local junk and do one more quick scan:

```bash
find . -name '.DS_Store' -delete
rg -n -i '(api[_-]?key|secret|token|password|BEGIN .* PRIVATE KEY|/Users/)' .
```

Also review whether you want to keep or ignore local-only files such as:

- `wezterm/local.lua`
- `nvim/lua/config/local.lua`
- `.env`
- `.env.local`

### 4.3 Initialize the new repo with a safe identity

Make sure your Git identity is already set to your GitHub noreply email, then initialize the new repo:

```bash
git init
git branch -M main
git config user.name "archer0302"
git config user.email "<your GitHub noreply email>"
git add .
git commit -m "Initial public dotfiles commit"
```

Verify the first commit author before pushing:

```bash
git log -1 --format='%an <%ae>'
```

### 4.4 Create and push the new GitHub repo

With GitHub CLI:

```bash
gh repo create archer0302/dot-configs-public --public --source=. --remote=origin --push
```

Or manually:

```bash
git remote add origin https://github.com/archer0302/dot-configs-public.git
git push -u origin main
```

### 4.5 Retire the old public repo

After you confirm the new repo is correct:

1. Update any local symlinks, notes, or bookmarks that reference the old repo.
2. Make the old repo **private**, **archive** it, or **delete** it.
3. Keep in mind that forks, clones, and third-party mirrors may still retain old history.

If your goal is risk reduction rather than preserving history, this is generally easier than rewriting the old repo.

## 5. Optionally rewrite public history

If you want to scrub the already-public commit metadata and old machine-specific paths, use `git filter-repo`.

This is optional. It reduces privacy leakage, but it is disruptive:

- all commit SHAs change
- open PRs and forks can be affected
- collaborators must re-clone or carefully reset
- old data may still exist in forks, mirrors, or caches outside your control

### 5.1 Install the tool

On macOS:

```bash
brew install git-filter-repo
```

### 5.2 Work from a fresh mirror clone

`git filter-repo` is intentionally designed to run against a fresh clone.

```bash
git clone --mirror https://github.com/archer0302/dot-configs.git dot-configs-scrub.git
cd dot-configs-scrub.git
```

### 5.3 Rewrite author identities

Create a mailmap file one directory above the mirror clone:

```bash
cat > ../mailmap.txt <<'EOF'
archer0302 <YOUR_GITHUB_NOREPLY_EMAIL> Archer Chang <archer.chang32@gmail.com>
archer0302 <YOUR_GITHUB_NOREPLY_EMAIL> Archer Chang <archer.chang@wisetechglobal.com>
archer0302 <YOUR_GITHUB_NOREPLY_EMAIL> Archer Chang <archer.chang@An-Chiehs-MacBook-Pro.local>
archer0302 <YOUR_GITHUB_NOREPLY_EMAIL> archer0302 <archer.chang32@gmail.com>
EOF
```

This rewrites author, committer, and tagger identity metadata to the noreply identity you want to keep.

### 5.4 Rewrite historical absolute paths in file contents

If you also want to scrub old machine-specific paths from historical file contents, create a replacement file:

```bash
cat > ../replacements.txt <<'EOF'
"/Users/archer.chang/.config/wezterm/resources/wezterm_bg_01_fixed.png"==>wezterm.home_dir .. "/.config/wezterm/resources/wezterm_bg_01_fixed.png"
"/Users/archer.chang/.local/share/nvim/mason/packages/codelldb/codelldb"==>vim.fn.stdpath("data") .. "/mason/packages/codelldb/codelldb"
EOF
```

Then run the rewrite:

```bash
git filter-repo --mailmap ../mailmap.txt --replace-text ../replacements.txt
```

### 5.5 Force-push the rewritten history

After checking the rewritten history locally:

```bash
git push --force --mirror origin
```

Then:

- re-check the public repository on GitHub
- tell collaborators to re-clone
- delete any stale local clones you no longer need
- keep the untouched backup until you are satisfied with the rewrite

## 6. Add a quick pre-push review habit

Before pushing a public change, run a quick scan:

```bash
rg -n -i '(api[_-]?key|secret|token|password|BEGIN .* PRIVATE KEY|/Users/)' .
git diff --cached
```

Occasionally audit the identities visible in your history:

```bash
git log --all --format='%an <%ae>' | sort -u
```

This catches both secrets and privacy leaks before they land in public history.

## 7. If a real secret is ever committed later

If you ever accidentally commit an actual credential:

1. **Rotate or revoke it immediately.**
2. Remove it from the current working tree.
3. Rewrite history to purge it from old commits.
4. Force-push the cleaned history.
5. Notify anyone who may have cloned or mirrored the repository.

For real secrets, rotation comes first. History cleanup alone is not enough.

## Recommended order for this repo

If you want the highest value for the least disruption, do the steps in this order:

1. Switch Git to your GitHub noreply email and enable `user.useConfigOnly`.
2. Keep machine-specific values in ignored local override files.
3. Keep `.DS_Store`, `.env`, and similar local files untracked.
4. Decide whether you want a fresh new repo or a history rewrite.

For this specific repo, starting a fresh repo is the simplest privacy cleanup if you do not need to preserve old history.
