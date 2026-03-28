---
name: playwright-explore-website
description: "Explore a website interactively to map its UI, user flows, and testable features using the Playwright MCP server. Use when the user wants to understand a web app before writing tests, discover testable scenarios, audit page structure, or investigate how a feature works in the browser."
---

# Website Exploration for Testing

Explore a website interactively via the Playwright MCP server to map its structure, discover user flows, and identify testable scenarios. This skill produces a structured exploration report — not test code. For test generation, hand off to the `playwright-generate-test` skill.

## Prerequisites

- Playwright MCP server must be available
- A target URL (ask the user if not provided)

## Exploration workflow

1. **Navigate** to the target URL via Playwright MCP `browser_navigate`
2. **Take a snapshot** with `browser_snapshot` to capture the initial accessibility tree
3. **Identify core areas**: navigation, main content, forms, interactive elements
4. **Interact** with 3–5 key features using `browser_click`, `browser_type`, `browser_select_option`
5. **Take snapshots after each interaction** to record state changes
6. **Screenshot key states** with `browser_take_screenshot` for visual reference
7. **Close** the browser context with `browser_close` when done

## What to look for

- **Navigation structure**: menus, links, routing patterns
- **Forms and inputs**: text fields, dropdowns, checkboxes, submit buttons
- **Dynamic content**: modals, accordions, tabs, lazy-loaded sections
- **User flows**: login → dashboard, search → results → detail, cart → checkout
- **State changes**: loading indicators, error messages, success confirmations
- **Accessibility**: landmarks, headings hierarchy, ARIA labels

## Locator strategy

When documenting elements, prefer resilient locators in this order:

1. `getByRole('button', { name: 'Submit' })` — role + accessible name
2. `getByLabel('Email')` — form fields by label
3. `getByText('Sign in')` — visible text
4. `getByTestId('checkout-btn')` — data-testid attributes
5. CSS/XPath — last resort only

## Output format

Present findings as a structured report:

```markdown
## Exploration Report: [Site Name]

**URL**: https://example.com
**Date**: YYYY-MM-DD

### Pages Explored

| Page | URL | Key Elements                           |
| ---- | --- | -------------------------------------- |
| Home | /   | Search bar, featured items, navigation |
| ...  | ... | ...                                    |

### User Flows Identified

1. **[Flow name]**: Step A → Step B → Step C
   - Key locators: `getByRole(...)`, `getByLabel(...)`
   - Expected outcome: ...

### Suggested Test Scenarios

- [ ] Scenario 1: description
- [ ] Scenario 2: description
```

## Tips

- Start broad (snapshot the whole page), then drill into specific sections
- If a page has a lot of interactive elements, prioritize the primary user flows
- Note any unexpected behaviors or broken elements — these make good test cases
- If navigation changes the URL, record the URL pattern for later assertions
