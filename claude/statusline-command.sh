#!/bin/bash
# Claude Code status line: branch · path · model/effort · context · usage
input=$(cat)

cwd=$(printf '%s' "$input"    | jq -r '.workspace.current_dir // empty')
model=$(printf '%s' "$input"  | jq -r '.model.display_name // "?"')
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')
ctx=$(printf '%s' "$input"    | jq -r '.context_window.used_percentage // empty')
five=$(printf '%s' "$input"   | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(printf '%s' "$input"   | jq -r '.rate_limits.seven_day.used_percentage // empty')

branch=$(git --no-optional-locks -C "${cwd:-.}" branch --show-current 2>/dev/null)
path=${cwd:-?}
case "$path" in "$HOME"*) path="~${path#"$HOME"}" ;; esac

GREEN=$'\033[38;5;108m'; BLUE=$'\033[38;5;110m'; LILAC=$'\033[38;5;146m'
GREY=$'\033[38;5;245m';  DARK=$'\033[38;5;240m'
AMBER=$'\033[38;5;179m'; RED=$'\033[38;5;174m'; R=$'\033[0m'

# Tint a percentage by how alarming it is.
tint() {
  local p=${1%%.*}
  if   [ "${p:-0}" -lt 50 ]; then printf '%s' "$GREEN"
  elif [ "${p:-0}" -lt 80 ]; then printf '%s' "$AMBER"
  else                            printf '%s' "$RED"
  fi
}
pct() { printf '%.0f' "$1"; }

sep="${DARK}·${R}"
out="${GREEN}${branch:-no-git}${R} ${sep} ${BLUE}${path}${R} ${sep} ${LILAC}${model}${R}"
[ -n "$effort" ] && out="${out} ${GREY}${effort}${R}"

if [ -n "$ctx" ]; then
  out="${out} ${sep} $(tint "$ctx")ctx $(pct "$ctx")%${R}"
fi

if [ -n "$five" ] || [ -n "$week" ]; then
  usage=""
  [ -n "$five" ] && usage="$(tint "$five")$(pct "$five")%${R}"
  [ -n "$week" ] && usage="${usage:+${usage}${DARK}/${R}}$(tint "$week")$(pct "$week")%${R}"
  out="${out} ${sep} ${usage}"
fi

printf '%s' "$out"
