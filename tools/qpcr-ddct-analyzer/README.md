# qPCR ddCT Analyzer

## What this tool does

`qpcr_analyzer_gui.py` is a Python GUI for analyzing qPCR experiments with the standard ddCT workflow. It helps users map sample, target, and CT columns; set per-target controls; omit selected combinations; export calculations; and generate plots.

## Why it is useful

qPCR analysis often involves repetitive spreadsheet cleanup, manual control selection, and hand-built plots. This tool bundles those tasks into a single workflow so users can go from exported CT values to interpretable outputs more quickly.

## Requirements

- Python 3.8+
- Packages listed in `requirements.txt`

Install dependencies with:

```bash
pip install -r requirements.txt
```

## Usage

Run the application with:

```bash
python qpcr_analyzer_gui.py
```

Typical workflow:

1. Load an Excel file containing qPCR CT results.
2. Map the sample, target, and CT columns.
3. Optionally map a grouping column for custom tasks.
4. Set reference target and reference sample controls.
5. Optionally omit target/sample pairs.
6. Generate the analysis outputs.

## Input

The app expects an Excel workbook (`.xlsx` or `.xls`) containing columns for:

- sample names
- target names
- CT values
- optionally a grouping/task column

## Output

The app writes output files next to the source Excel file, including:

- a tab-separated table of calculated values
- one or more PNG plots
- optional saved JSON config templates created by the user

## Example

See the `examples/` directory for:

- a sample JSON config template
- a small mock qPCR table in TSV format that documents the expected tabular structure
- example usage notes

## Notes

- The GUI reads Excel input files, so the mock table in `examples/` is provided as documentation rather than a direct drop-in GUI input.
- The bundled `template.json` can be used as a starting point for saved control mappings.
