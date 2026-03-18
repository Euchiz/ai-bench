# Tools

This directory contains the self-contained utilities that make up **bench-miyano**.

## Included tools

### `nuc-helper/`

Command-line helper for cleaning, validating, converting, and reverse-complementing DNA/RNA sequences.

- Main script: `nuc_helper.py`
- Local documentation: `README.md`
- Examples: `examples/example_commands.md`, `examples/example_sequences.txt`

### `qpcr-ddct-analyzer/`

GUI application for qPCR ddCT analysis with control mapping, omission support, exports, and plots.

- Main script: `qpcr_analyzer_gui.py`
- Dependency file: `requirements.txt`
- Config template: `template.json`
- Local documentation: `README.md`
- Examples: `examples/README.md`, `examples/mock_qpcr_input.tsv`, `examples/example_template.json`

## Tool folder expectations

Each tool folder should include:

- the runnable script(s)
- a local `README.md`
- an `examples/` directory with sample inputs, outputs, or usage notes when appropriate
