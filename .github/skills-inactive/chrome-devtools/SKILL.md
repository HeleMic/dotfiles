---
name: chrome-devtools
description: "Expert-level browser automation, debugging, and performance analysis using Chrome DevTools MCP. Use this skill whenever the user needs to interact with a live browser — navigating pages, clicking elements, filling forms, capturing screenshots, inspecting console logs, analyzing network traffic, profiling performance, or emulating devices. Also use when the user asks to debug a web page, check why something looks wrong, or investigate slow loading times."
---

# Chrome DevTools Agent

Control and inspect a live Chrome browser via the `chrome-devtools` MCP server — from simple navigation to complex performance profiling.

## When to use (and when not to)

**Use this skill for:**

- Browser automation: navigating, clicking, filling forms, handling dialogs
- Visual inspection: screenshots and accessibility-tree snapshots
- Debugging: console messages, JavaScript evaluation, network request analysis
- Performance profiling: traces, Core Web Vitals, layout shift investigation
- Device emulation: viewport resize, network/CPU throttling

**Prefer Playwright MCP instead when** you need to write or run automated test suites — this skill is for interactive exploration and debugging, not test generation.

## Tool Categories

### 1. Navigation & Page Management

- `new_page`: Open a new tab/page.
- `navigate_page`: Go to a specific URL, reload, or navigate history.
- `select_page`: Switch context between open pages.
- `list_pages`: See all open pages and their IDs.
- `close_page`: Close a specific page.
- `wait_for`: Wait for specific text to appear on the page.

### 2. Input & Interaction

- `click`: Click on an element (use `uid` from snapshot).
- `fill` / `fill_form`: Type text into inputs or fill multiple fields at once.
- `hover`: Move the mouse over an element.
- `press_key`: Send keyboard shortcuts or special keys (e.g., "Enter", "Control+C").
- `drag`: Drag and drop elements.
- `handle_dialog`: Accept or dismiss browser alerts/prompts.
- `upload_file`: Upload a file through a file input.

### 3. Debugging & Inspection

- `take_snapshot`: Get a text-based accessibility tree (best for identifying elements).
- `take_screenshot`: Capture a visual representation of the page or a specific element.
- `list_console_messages` / `get_console_message`: Inspect the page's console output.
- `evaluate_script`: Run custom JavaScript in the page context.
- `list_network_requests` / `get_network_request`: Analyze network traffic and request details.

### 4. Emulation & Performance

- `resize_page`: Change the viewport dimensions.
- `emulate`: Throttling CPU/Network or emulating geolocation.
- `performance_start_trace`: Start recording a performance profile.
- `performance_stop_trace`: Stop recording and save the trace.
- `performance_analyze_insight`: Get detailed analysis from recorded performance data.

## Workflow Patterns

### Pattern A: Identifying Elements (Snapshot-First)

Always prefer `take_snapshot` over `take_screenshot` for finding elements. The snapshot provides `uid` values which are required by interaction tools.

```markdown
1. `take_snapshot` to get the current page structure.
2. Find the `uid` of the target element.
3. Use `click(uid=...)` or `fill(uid=..., value=...)`.
```

### Pattern B: Troubleshooting Errors

When a page is failing, check both console logs and network requests.

```markdown
1. `list_console_messages` to check for JavaScript errors.
2. `list_network_requests` to identify failed (4xx/5xx) resources.
3. `evaluate_script` to check the value of specific DOM elements or global variables.
```

### Pattern C: Performance Profiling

Identify why a page is slow.

```markdown
1. `performance_start_trace(reload=true, autoStop=true)`
2. Wait for the page to load/trace to finish.
3. `performance_analyze_insight` to find LCP issues or layout shifts.
```

## Best Practices

- **Context awareness**: Run `list_pages` and `select_page` when unsure which tab is active.
- **Snapshot freshness**: Take a new snapshot after any navigation or DOM change — `uid` values are ephemeral.
- **Timeouts**: Use reasonable `wait_for` timeouts; prefer waiting for specific text over arbitrary delays.
- **Screenshots vs snapshots**: Use `take_snapshot` for element identification (returns `uid`s), `take_screenshot` only for visual verification.
- **Error recovery**: If a click or fill fails, take a fresh snapshot — the DOM may have changed since the last one.
