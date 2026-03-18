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

## Design philosophy

Tools in **bench-miyano** should generally be:

- **simple to use**
- **practically useful**
- **clearly documented**
- **easy to modify**
- **lightweight and portable**

Whenever possible, each tool should:

- have a clear input/output behavior
- include helpful usage examples
- provide understandable error messages
- avoid unnecessary dependencies
- be usable by someone with limited coding experience

A good tool in this repo should feel like something a wet-lab person can quickly pick up and use without needing to learn a large framework.

---

## Who this repo is for

This repository is for:

- wet-lab researchers
- molecular biology students
- computationally curious bench scientists
- people who want small utilities for routine lab data handling
- contributors who want to share practical scripts with others

---

## Repository structure

Each tool should live in **its own folder**.

Example structure:

```text
bench-miyano/
├─ README.md
├─ tools/
│  ├─ helper/
│  │  ├─ helper.sh
│  │  ├─ README.md
│  │  └─ examples/
│  ├─ analyzer/
│  │  ├─ main.py
│  │  ├─ module.py
|  |  ├─ requirements.txt
│  │  ├─ README.md
│  │  └─ examples/
│  └─ calculator/
│     ├─ calculator.py
│     ├─ README.md
│     └─ examples/
└─ LICENSE
```

You may organize the repository differently as it grows, but the core principle remains:

> **one tool = one folder, with clear documentation and usage**

---

## What each tool folder should contain

Each tool folder should include:

### 1. The tool itself

The main script or scripts needed to run the utility.

Examples:

- `tool_name.py`
- `main.py`
- `run.sh`

### 2. A local README

Each tool should have its own `README.md` that explains:

- what the tool does
- why it is useful
- input format
- output format
- dependencies
- how to run it
- example usage
- notes or limitations

### 3. Example files when appropriate

If useful, include small example inputs and outputs so users can quickly understand how the tool works.

Examples:

- sample CSV files
- example command lines
- example output text

---

## Contribution guidelines

Contributions are welcome, especially tools that simplify real wet-lab workflows.

### General contribution standard

A contributed tool should be:

- **simple to use**
- **practically useful**
- **clearly described**
- **reasonably self-contained**
- **easy for others to understand and reuse**

### How to contribute a new tool

When adding a new tool:

1. **Create a new folder** for the tool.
2. Put the main script and any required supporting files inside that folder.
3. Add a **clear ****README.md** inside the tool folder.
4. Include **usage examples**.
5. Keep the interface as simple as possible.
6. Make sure the tool solves a practical problem relevant to wet-lab work.

### Suggested tool README template

Each tool-level README should ideally include:

```markdown
# Tool name

## What this tool does
Short description.

## Why it is useful
What problem it solves in wet-lab workflow.

## Requirements
List of dependencies.

## Usage
Command-line example or instructions.

## Input
Describe expected input.

## Output
Describe expected output.

## Example
Show a small realistic example.

## Notes
Any caveats, assumptions, or limitations.
```

### Preferred qualities of contributed tools

Strong contributions usually:

- solve repetitive manual tasks
- reduce spreadsheet-heavy busywork
- improve clarity of common analyses
- handle common lab file formats cleanly
- make frequent calculations easier and less error-prone
- provide outputs that are easy to interpret and copy into downstream workflows

Examples of good fits:

- sequence utilities
- primer/oligo helpers
- qPCR analysis tools
- plate map helpers
- dilution calculators
- assay result summarizers
- format converters for common instrument outputs

---

## Usage philosophy

This repo values tools that are:

- useful on day one
- quick to run
- easy to explain to a colleague
- realistic for everyday bench work

In general, prefer:

- a small clean script over a complicated package
- clear user instructions over clever implementation
- understandable outputs over overly dense results

---

## How to use this repository

You can browse the `tools/` directory and open the folder for any tool that matches your use case.

Each tool should tell you:

- what problem it solves
- how to run it
- what input it expects
- what output it produces

The aim is that users can quickly find a tool, read a short guide, and use it immediately.

---

## Notes for contributors

Please keep tools:

- focused
- readable
- well described
- practical

A tool does **not** need to be large or sophisticated to be valuable. Small scripts that save time and reduce mistakes are exactly the kind of contributions this repository wants.

---

## License

This project is released under the MIT license.

---

## Future directions

Possible future additions may include:

- a shared utilities module for common helper functions
- a lightweight index of available tools
- standardized example datasets
- optional tests for core tools
- a small documentation site if the repository grows substantially

---

## Contributing ideas

Even if you are not ready to contribute code, ideas are welcome.

Useful contribution ideas include:

- scripts you wish existed for your own lab workflow
- annoying repetitive analysis tasks
- common instrument export cleanup problems
- small transformations currently done manually in spreadsheets
- command-line helpers that make routine work easier

---

## Summary

**bench-miyano** is meant to be a practical open-source toolbox for wet-lab people: small scripts, clear usage, real utility.

If a tool saves time, reduces confusion, and helps someone at the bench get work done more easily, it belongs here.

