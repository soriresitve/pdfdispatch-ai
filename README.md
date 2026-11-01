# PDFDispatch for AI assistants

Make PDFs from HTML, Markdown, web pages and Word, Excel or PowerPoint files, merge PDFs and take screenshots, from
your AI assistant. This repository has the [Claude Code](https://code.claude.com) plugin and a rule file for
[Cursor](https://cursor.com). Both use the hosted [PDFDispatch MCP server](https://docs.pdfdispatch.com/mcp/) with
your own key, and add the habits that make good PDFs: print CSS, a screenshot check for layouts, and results saved
into your project.

You need a PDFDispatch key: [pdfdispatch.com/app/keys](https://pdfdispatch.com/app/keys) (100 PDFs a month are free).
Make one just for the assistant, so you can revoke it alone.

## Claude Code

In Claude Code:

```text
/plugin marketplace add soriresitve/pdfdispatch-ai
/plugin install pdfdispatch@pdfdispatch
```

Claude Code asks for your key and keeps it in your system's secure storage. Then ask for a PDF:

```text
Make a PDF invoice for the order in fixtures/order-1042.json and save it as out/invoice-1042.pdf.
```

To change the key later: `/plugin`, then configure PDFDispatch. From a shell instead:
`claude plugin marketplace add soriresitve/pdfdispatch-ai`, then
`claude plugin install pdfdispatch@pdfdispatch --config api_key=pdd_...`.

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
