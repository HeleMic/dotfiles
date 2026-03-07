# 🛠️ Coding Standards

This directory defines code quality standards (linting and formatting) for
JavaScript, TypeScript, and PHP (Laravel) projects.

## 📦 Included Tooling

- **Prettier**: Consistent formatting with plugins for import ordering, CSS, and
  package.json.
- **ESLint**: Linting to catch logical and stylistic errors.
- **Husky & Lint-Staged**: Runs automated checks before every commit.
- **Commitlint**: Enforces commit messages that follow
  [Conventional Commits](https://www.conventionalcommits.org/).
- **PHP**: Configuration for `Pint` (Laravel standard) and `PHPStan` (static
  analysis).

## 🚀 Usage in a Project

To apply these standards to a new project, run the provided setup script:

```bash
~/.dotfiles/bin/setup-project.sh
```

This script:

1.  Checks for a `package.json`.
2.  Installs the required `devDependencies` via `npm`.
3.  Initialises Husky.
4.  Copies configuration files (`.prettierrc`, `.commitlintrc.ts`, etc.) to the
    project root.
5.  (Optional) Adds PHP configuration if requested.
