# Nucleic Acid Helper

## What this tool does

`nuc_helper.py` is a small command-line utility for bench scientists who need to quickly clean, validate, convert, and optionally reverse-complement DNA or RNA sequences.

## Why it is useful

This tool is helpful when sequence text has been copied from emails, notebooks, spreadsheets, or instrument output and needs to be normalized before ordering oligos, pasting into another application, or sharing with a colleague.

## Requirements

- Python 3.8+
- No third-party Python dependencies

## Usage

```bash
python nuc_helper.py "AUG CUG UAA" --to dna
python nuc_helper.py "ATGCATGC" --to rna --revcomp
python nuc_helper.py "augcuu\nuaa" --to rna
```

## Input

- A single DNA or RNA sequence passed as a positional command-line argument
- Whitespace and common separators such as `-`, `_`, `.`, `,`, `;`, `:`, `|`, `/`, and `\` are stripped before validation

## Output

The script prints:

- the raw input
- the cleaned sequence
- validation status
- inferred input type
- converted output type
- sequence lengths
- a copy-paste-ready final sequence block

## Example

See the `examples/` directory for ready-to-run sample commands and representative output.

## Notes

- Mixed `T` and `U` input is rejected as ambiguous.
- Sequences containing only `A`, `C`, and `G` are treated as compatible with either DNA or RNA.
