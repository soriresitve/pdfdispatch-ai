#!/usr/bin/env bash
# Writes the Claude Code skill and the Cursor rule from rules/pdf-documents.md, the one place the text lives.
# Run it after editing that file; CI fails when the two copies are out of date.
set -euo pipefail
cd "$(dirname "$0")/.."

body=rules/pdf-documents.md

{
  printf '%s\n' '---' 'name: pdf-documents' \
    'description: Makes PDFs with the PDFDispatch MCP tools (render_template, html_to_pdf, markdown_to_pdf, url_to_pdf, office_to_pdf, merge_pdfs, screenshot, upload_file). Use when the user asks for a PDF, an invoice, report, certificate or other printable document, to convert Word, Excel or PowerPoint files to PDF, or to merge PDFs.' \
    '---' ''
  cat "$body"
} > plugins/pdfdispatch/skills/pdf-documents/SKILL.md

{
  printf '%s\n' '---' \
    'description: How to make PDFs with the PDFDispatch MCP tools (render_template, html_to_pdf, markdown_to_pdf, url_to_pdf, office_to_pdf, merge_pdfs, screenshot, upload_file). Use when asked for a PDF, an invoice, report or other printable document, an Office file converted to PDF, or merged PDFs.' \
    'alwaysApply: false' '---' ''
  cat "$body"
} > cursor/pdfdispatch.mdc
