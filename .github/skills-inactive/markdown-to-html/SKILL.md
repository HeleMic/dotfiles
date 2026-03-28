---
name: markdown-to-html
description: "Convert Markdown files to HTML using tools like marked.js, pandoc, or gomarkdown — or build custom conversion scripts. Use this skill when the user asks to convert markdown to HTML, render markdown, generate HTML from .md files, build a static site from markdown, or work with templating systems like Jekyll or Hugo that process markdown into HTML."
---

# Markdown to HTML Conversion

Convert Markdown documents to HTML. This skill covers multiple tools and workflows — choose the right one based on the user's environment and needs.

## Choosing a tool

| Tool            | Best for                                           | Language         | Install                                                     |
| --------------- | -------------------------------------------------- | ---------------- | ----------------------------------------------------------- |
| **marked**      | Node.js projects, CLI quick conversions            | JavaScript       | `npm install -g marked`                                     |
| **pandoc**      | Multi-format conversion, academic docs, PDF output | Haskell (binary) | [pandoc.org/installing](https://pandoc.org/installing.html) |
| **gomarkdown**  | Go projects needing programmatic conversion        | Go               | `go get github.com/gomarkdown/markdown`                     |
| **Jekyll/Hugo** | Static site generation from markdown content       | Ruby / Go        | Project-specific                                            |

If the user doesn't specify a tool, recommend **marked** for JavaScript projects and **pandoc** for everything else.

## Quick conversions

### With marked (CLI)

```bash
# Single file
marked -i input.md -o output.html

# With GFM enabled
marked -i input.md -o output.html --gfm
```

### With pandoc

```bash
# Basic conversion
pandoc input.md -o output.html

# Standalone HTML with styles
pandoc input.md -o output.html --standalone

# With table of contents
pandoc input.md -o output.html --standalone --toc
```

### With marked (Node.js)

```javascript
import { marked } from "marked";
import { readFileSync, writeFileSync } from "fs";

const markdown = readFileSync("input.md", "utf-8");
const html = marked.parse(markdown);
writeFileSync("output.html", html);
```

## Security

Markdown-to-HTML converters generally do NOT sanitize output. When processing untrusted input, always sanitize:

```javascript
import { marked } from "marked";
import DOMPurify from "dompurify";

const html = DOMPurify.sanitize(marked.parse(untrustedMarkdown));
```

Recommended sanitizers: [DOMPurify](https://github.com/cure53/DOMPurify), [sanitize-html](https://github.com/apostrophecms/sanitize-html).

## Reference files

For detailed conversion examples and advanced usage, read these files from the skill's `references/` folder:

| File                                                     | Content                                                         |
| -------------------------------------------------------- | --------------------------------------------------------------- |
| `references/basic-markdown-to-html.md`                   | Basic element conversions (headings, links, lists, code blocks) |
| `references/code-blocks-to-html.md`                      | Code block and syntax highlighting conversions                  |
| `references/collapsed-sections-to-html.md`               | `<details>`/`<summary>` handling                                |
| `references/writing-mathematical-expressions-to-html.md` | LaTeX/MathML conversion                                         |
| `references/tables-to-html.md`                           | Table alignment and structure                                   |
| `references/marked.md`                                   | Full marked.js API, config options, and workflows               |
| `references/pandoc.md`                                   | Pandoc options, templates, and multi-format output              |

Read the relevant reference file when you need detailed examples for a specific conversion type — don't try to memorize all conversions upfront.

## Common issues

| Issue                       | Solution                                                                         |
| --------------------------- | -------------------------------------------------------------------------------- |
| Tables not rendering        | Enable GFM: `--gfm` (marked) or use `-f gfm` (pandoc)                            |
| Line breaks ignored         | Set `breaks: true` (marked) or use `hard_line_breaks` extension (pandoc)         |
| Code blocks not highlighted | Add syntax highlighter (highlight.js for marked, `--highlight-style` for pandoc) |
| Special chars at file start | Strip BOM: `content.replace(/^\uFEFF/, '')`                                      |
