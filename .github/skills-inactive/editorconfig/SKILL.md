---
name: editorconfig
description: "Generate a project-specific .editorconfig file based on analysis of the repository languages and structure. Use this skill when the user asks to create, generate, or set up an .editorconfig — or when they want consistent code formatting across editors and IDEs."
---

# Generate .editorconfig

Create a `.editorconfig` file tailored to the project's actual languages and file types.

## Workflow

1. **Analyze the project** — scan the workspace for file extensions, existing config files (`.prettierrc`, `eslint.config.*`, `tsconfig.json`, etc.), and directory structure to infer the languages and frameworks in use.
2. **Ask about preferences** — if the user hasn't specified, ask:
   - Indentation style: spaces or tabs?
   - Indentation size: 2, 4, or other?
   - Any language-specific overrides?
3. **Generate the config** — create `.editorconfig` at the project root with sections for each language/file type found.
4. **Explain the rules** — provide a brief explanation of each section.

## Universal defaults

These apply to all files unless overridden:

```editorconfig
root = true

[*]
end_of_line = lf
charset = utf-8
trim_trailing_whitespace = true
insert_final_newline = true
```

## Common language overrides

Apply these based on what's actually in the project:

| File pattern     | Common settings                    | Why                                                      |
| ---------------- | ---------------------------------- | -------------------------------------------------------- |
| `*.md`           | `trim_trailing_whitespace = false` | Trailing spaces are meaningful in Markdown (line breaks) |
| `*.yaml, *.yml`  | `indent_size = 2`                  | YAML standard convention                                 |
| `Makefile`       | `indent_style = tab`               | Make requires tabs                                       |
| `*.go`           | `indent_style = tab`               | Go convention (gofmt)                                    |
| `*.py`           | `indent_size = 4`                  | PEP 8 standard                                           |
| `*.{json,jsonc}` | `indent_size = 2`                  | Common web ecosystem convention                          |

## Output

Produce two things:

1. **The `.editorconfig` file** — complete and ready to use
2. **Rule explanations** — a brief note per section explaining what it does and why, so the user can adjust if needed

## Tips

- Check for an existing `.editorconfig` before creating one — if one exists, suggest improvements rather than overwriting.
- If the project has a `.prettierrc` or equivalent, align indentation settings with it rather than introducing conflicts.
- The `root = true` directive is important — without it, editors search parent directories and might pick up unrelated configs.
