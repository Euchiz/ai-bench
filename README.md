# bench-miyano

**bench-miyano** is an open-source collection of handy scripts and small tools for wet-lab scientists.

The goal of this repository is to make everyday bench-facing data tasks easier, faster, and less frustrating by providing simple, practical, and well-documented utilities that solve real workflow problems.

This project is intentionally focused on **practical usefulness** over complexity. Each tool should be easy to understand, easy to run, and immediately helpful in real lab work.

---

## Project goals

This repository aims to:

- provide simple open-source tools for common wet-lab data tasks
- reduce repetitive manual work in day-to-day molecular biology workflows
- make small utilities easy to discover, use, and adapt
- keep tools lightweight, readable, and accessible to non-specialist users
- encourage community contributions of useful bench-side scripts

This is **not** intended to be a large monolithic software package. Instead, it is a curated toolbox of focused utilities, where each tool solves one practical problem well.

---

## Repository structure

Tools should live under `tools/`, with **one tool = one folder, with clear documentation and examples**.

Example structure:

```text
bench-miyano/
├─ README.md
├─ tools/
│  ├─ README.md
│  ├─ helper-script/
│  │  ├─ helper.sh
│  │  ├─ README.md
│  │  └─ examples/
│  ├─ analyzer-app/
│  │  ├─ main.py
│  │  ├─ requirements.txt
│  │  ├─ README.md
│  │  └─ examples/
│  └─ converter/
│     ├─ convert.py
│     ├─ README.md
│     └─ examples/
└─ LICENSE
```

The exact layout can evolve as the repository grows, but the guiding idea stays the same:

> **one tool = one folder, with clear documentation and usage**

---

## What each tool folder should contain

Each tool folder should include:

1. the runnable tool files
2. a local `README.md`
3. an `examples/` directory with sample inputs, outputs, templates, or usage notes when appropriate

---

## Contribution guidelines

When adding a new tool:

1. Create a new folder under `tools/`.
2. Keep the implementation self-contained inside that folder.
3. Add a tool-specific `README.md`.
4. Add an `examples/` directory with at least one practical example or template when appropriate.
5. Keep the interface simple and bench-friendly.
6. Prefer lightweight dependencies and clear input/output behavior.

## Usage philosophy

This repo values tools that are:

- useful on day one
- quick to run
- easy to explain to a colleague
- realistic for everyday bench work

In general, prefer:

- focused tools over large frameworks
- explicit documentation over assumptions
- practical examples over abstract descriptions
