#!/usr/bin/env bash
# What CI checks (.github/workflows/ci.yml). Needs `npm ci` first, for the pinned Claude Code in package.json.
set -euo pipefail
cd "$(dirname "$0")/.."

claude=node_modules/.bin/claude

# The skill and the Cursor rule are written from rules/pdf-documents.md.
scripts/sync-rules.sh
git diff --exit-code -- plugins/pdfdispatch/skills cursor ||
  { echo "check: run scripts/sync-rules.sh and commit the result" >&2; exit 1; }

# The marketplace and the plugin, warnings included.
"$claude" plugin validate --strict .
"$claude" plugin validate --strict ./plugins/pdfdispatch

# The plugin's version must change with its files, or users who installed it never get the change. Compared with
# master on pull requests only.
if [[ -n ${BASE_REF:-} ]]; then
  if ! git diff --quiet "origin/$BASE_REF" -- plugins/pdfdispatch; then
    old=$(git show "origin/$BASE_REF:plugins/pdfdispatch/.claude-plugin/plugin.json" | node -p 'JSON.parse(require("fs").readFileSync(0)).version')
    new=$(node -p 'require("./plugins/pdfdispatch/.claude-plugin/plugin.json").version')
    [[ $old != "$new" ]] || { echo "check: plugins/pdfdispatch changed, raise \"version\" in its plugin.json ($old)" >&2; exit 1; }
  fi
fi
echo "check: ok"
