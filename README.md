# PDFDispatch for AI assistants

Make PDFs from HTML, Markdown, web pages and Word, Excel or PowerPoint files, merge PDFs and take screenshots, from
your AI assistant. This repository has the [Claude Code](https://code.claude.com) plugin and a rule file for
[Cursor](https://cursor.com). Both use the hosted [PDFDispatch MCP server](https://docs.pdfdispatch.com/mcp/) with
your account (you sign in, or use a key), and add the habits that make good PDFs: print CSS, a screenshot check for layouts, and results saved
into your project.

You need a PDFDispatch account: [pdfdispatch.com](https://pdfdispatch.com) (100 PDFs a month are free). Claude Code signs
in to it; Cursor and other assistants can sign in too, or use a key.

## Claude Code

In Claude Code:

```text
/plugin marketplace add soriresitve/pdfdispatch-ai
/plugin install pdfdispatch@pdfdispatch
```

Then run `/mcp`, pick `plugin:pdfdispatch:pdfdispatch` and choose **Authenticate**. Your browser opens pdfdispatch.com:
log in and choose **Connect**. There is no key to copy: the connection gets its own key on your
[Keys page](https://pdfdispatch.com/app/keys), marked Connection, and revoking it there disconnects Claude Code.
Then ask for a PDF:

```text
Make a PDF invoice for the order in fixtures/order-1042.json and save it as out/invoice-1042.pdf.
```

From a shell instead: `claude plugin marketplace add soriresitve/pdfdispatch-ai`, then
`claude plugin install pdfdispatch@pdfdispatch`. To use a key you made yourself instead of signing in, add the server
without the plugin, as the [MCP docs](https://docs.pdfdispatch.com/mcp/#claude-code) show.

## Cursor

1. Add the MCP server: the "Add to Cursor" button on [pdfdispatch.com/ai](https://pdfdispatch.com/ai), or the
   setup in the [MCP docs](https://docs.pdfdispatch.com/mcp/#cursor). It reads your key from the `PDD_KEY`
   environment variable.
2. Copy [`cursor/pdfdispatch.mdc`](cursor/pdfdispatch.mdc) into your project as `.cursor/rules/pdfdispatch.mdc`.

## Other assistants

The same guidance as plain Markdown is in [`rules/pdf-documents.md`](rules/pdf-documents.md). Paste it into your
assistant's instructions (`AGENTS.md`, `CLAUDE.md`, a system prompt), and add the MCP server as the
[docs](https://docs.pdfdispatch.com/mcp/#setup) show.

## Changing this repository

- The guidance lives in `rules/pdf-documents.md`. After editing it, run `scripts/sync-rules.sh`, which writes the
  Claude Code skill and the Cursor rule from it.
- Raise `version` in `plugins/pdfdispatch/.claude-plugin/plugin.json` with every change to the plugin, or people who
  installed it never get the change.
- Check: `npm ci && scripts/check.sh` (CI runs the same). Pull requests merge through policy-bot (`.policy.yml`,
  `.bulldozer.yml`).

Questions: support@pdfdispatch.com. License: MIT.
