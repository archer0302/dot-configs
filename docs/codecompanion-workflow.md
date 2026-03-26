# CodeCompanion workflow

## 1) Pre-flight

1. Ensure your adapter auth is ready (current config uses `gemini_cli` ACP adapter).
2. In Neovim, run `:checkhealth codecompanion` if chat/inline features fail.

## 2) Daily flow

1. Open chat with `:CodeCompanionChat`.
2. Add code context:
   - Use `#` for editor context (buffer/file references).
   - Use `/` slash commands for extra context/actions.
3. Ask for planning or implementation in chat.
4. Use inline edits for focused changes:
   - `:CodeCompanion <prompt>`
   - In visual mode, select lines then run `:CodeCompanion /fix` or `:CodeCompanion /tests`.
5. Use action palette for common tasks:
   - `:CodeCompanionActions`
6. Keep long work in chat; use inline assistant for surgical edits.

## 3) Command quick reference

- `:CodeCompanion` - inline assistant
- `:CodeCompanionChat` - open chat buffer
- `:CodeCompanionChat Toggle` - toggle chat buffer
- `:CodeCompanionCmd` - generate command-line commands
- `:CodeCompanionActions` - open action palette

## 4) Recommended prompt rhythm

1. **Plan first**: ask for a small staged plan.
2. **Execute one stage**: request minimal edits.
3. **Verify**: ask for checks to run.
4. **Refine**: request cleanup or follow-up edge cases.
