---
name: documentation-writer
description: 'Write high-quality software documentation using the Diátaxis framework (Tutorials, How-to Guides, Reference, Explanation). Use this skill when the user asks to write docs, create a tutorial, document an API, write a how-to guide, create a reference page, or explain a concept — even if they just say "write docs for this" or "document this feature". Do NOT use for README creation (use create-readme instead).'
---

# Diátaxis Documentation Writer

Write software documentation guided by the [Diátaxis framework](https://diataxis.fr/), which organizes docs into four types based on user needs.

## Choosing the right document type

| Type             | User need                  | Analogy      | Example                       |
| ---------------- | -------------------------- | ------------ | ----------------------------- |
| **Tutorial**     | "I want to learn"          | A lesson     | "Build your first CLI tool"   |
| **How-to Guide** | "I need to solve X"        | A recipe     | "How to configure SSO"        |
| **Reference**    | "I need the details"       | A dictionary | "API endpoint reference"      |
| **Explanation**  | "I want to understand why" | A discussion | "Why we chose event sourcing" |

If the user doesn't specify a type, infer from context:

- Asking about getting started or learning → **Tutorial**
- Asking how to do something specific → **How-to Guide**
- Asking for API docs, config options, CLI flags → **Reference**
- Asking why something works a certain way → **Explanation**

When in doubt, ask: "Would this be more of a step-by-step guide or a reference page?"

## Workflow

1. **Clarify scope** — determine: document type, target audience (beginner/intermediate/expert), user goal, and what to include/exclude.
2. **Propose an outline** — present a table of contents with brief section descriptions. Wait for approval before writing.
3. **Write the content** — in well-formatted Markdown, following the principles below.

## Writing principles

- **Clarity**: simple, unambiguous language. Short sentences. Active voice.
- **Accuracy**: code snippets must be correct and tested. Technical details must be precise.
- **User-centricity**: every section helps the reader achieve something or understand something. Cut anything that doesn't.
- **Consistency**: maintain consistent tone, terminology, and formatting within a document and across related docs.

## Type-specific guidance

### Tutorials

- Start with what the reader will build/achieve (not with theory)
- Every step should produce a visible result
- Include the complete code at each meaningful checkpoint
- End with a "what you've learned" summary and next steps

### How-to Guides

- Start with the problem being solved
- Assume the reader already has basic knowledge
- Keep it focused — one guide, one problem
- Include troubleshooting tips for common pitfalls

### Reference

- Organize by the structure of the thing being documented (not by use case)
- Be exhaustive — cover every parameter, option, and return value
- Use tables for structured information
- Don't explain concepts — link to Explanation docs instead

### Explanation

- Explain the reasoning, trade-offs, and context behind decisions
- Connect concepts to each other
- It's OK to be conversational and explore nuance
- Don't include step-by-step instructions — link to How-to Guides instead

## Context awareness

When provided with existing Markdown files, use them to match the project's tone, terminology, and formatting conventions — but don't copy content unless explicitly asked.
