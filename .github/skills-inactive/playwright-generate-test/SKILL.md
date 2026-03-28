---
name: playwright-generate-test
description: "Generate a Playwright test from a user scenario by first interacting with the live site via the Playwright MCP server, then emitting a working TypeScript test. Use when the user asks to create, write, or generate a Playwright test for a specific feature, flow, or scenario."
---

# Test Generation with Playwright MCP

Generate a Playwright TypeScript test by first interacting with the real site via Playwright MCP, then writing a test based on what you observed. Never generate test code from the scenario alone — always verify against the live page first.

## Workflow

### 1. Clarify the scenario

If the user doesn't provide a scenario, ask for one. A good scenario includes:

- Target URL
- User action(s) to perform
- Expected outcome

### 2. Interact with the live site (mandatory)

Use Playwright MCP tools step by step:

1. `browser_navigate` — open the target URL
2. `browser_snapshot` — capture the accessibility tree to discover locators
3. `browser_click` / `browser_type` / `browser_select_option` — perform the user actions
4. `browser_snapshot` — capture the resulting state
5. `browser_take_screenshot` — capture visual reference if helpful

Record every locator and state change you observe. These real locators go into the test.

### 3. Write the test

Generate a TypeScript test following the project's Playwright conventions (see `playwright-typescript.instructions.md`). Key rules:

- Import from `@playwright/test`
- Use `test.step()` to group logical actions
- Use role-based locators: `getByRole`, `getByLabel`, `getByText`
- Use web-first assertions: `await expect(locator).toHaveText()`, `toHaveURL()`, `toMatchAriaSnapshot()`
- No hard-coded waits — rely on Playwright auto-waiting
- Descriptive test names: `'should [expected behavior] when [action]'`

### 4. Save and run

- Save to `tests/<feature>.spec.ts`
- Run: `npx playwright test tests/<feature>.spec.ts --project=chromium`

### 5. Iterate until green

If the test fails:

1. Read the error output carefully
2. Check if locators have changed (re-snapshot if needed)
3. Fix the specific issue — don't rewrite the whole test
4. Re-run and confirm the fix

Repeat until the test passes. Typically 1–3 iterations are enough.

### 6. Close the browser

Use `browser_close` when done.

## Example output

```typescript
import { test, expect } from "@playwright/test";

test.describe("Search Feature", () => {
  test("should display results when searching for a term", async ({ page }) => {
    await page.goto("https://example.com");

    await test.step("perform search", async () => {
      await page.getByRole("searchbox", { name: "Search" }).fill("playwright");
      await page.getByRole("searchbox", { name: "Search" }).press("Enter");
    });

    await test.step("verify results appear", async () => {
      await expect(
        page.getByRole("heading", { name: "Search Results" }),
      ).toBeVisible();
      await expect(
        page.getByRole("list", { name: "results" }).getByRole("listitem"),
      ).toHaveCount(10);
    });
  });
});
```

## Common pitfalls

| Problem                           | Fix                                                                                |
| --------------------------------- | ---------------------------------------------------------------------------------- |
| Locator matches multiple elements | Make it more specific — add `{ name: '...' }` or chain with `.filter()`            |
| Test flaky due to timing          | Use `await expect(...).toHaveText()` instead of snapshot checks on dynamic content |
| Test passes locally, fails in CI  | Check viewport size and use `--project=chromium` consistently                      |
