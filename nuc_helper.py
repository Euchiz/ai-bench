#!/usr/bin/env python3
"""
nuc_helper.py

A convenience command-line nucleic acid helper script.

Features:
- Accepts a DNA/RNA sequence from command line
- Cleans up whitespace, line breaks, and common formatting noise
- Validates whether the sequence is legal DNA/RNA
- Reports issues clearly if invalid
- Converts sequence to DNA or RNA
- Optionally outputs reverse complement
- Prints sequence lengths
- Prints final sequence in a clean copy-paste-friendly block

Examples:
    python nuc_helper.py "AUG CUG UAA" --to dna
    python nuc_helper.py "ATGCATGC" --to rna --revcomp
    python nuc_helper.py "augcuu\nuaa" --to rna
"""

from __future__ import annotations

import argparse
import re
import sys


DNA_BASES = set("ACGT")
RNA_BASES = set("ACGU")
ALL_BASES = set("ACGTU")


def clean_sequence(seq: str) -> str:
    """
    Remove whitespace and common separators, then uppercase.
    Keeps only raw characters for validation afterward.
    """
    seq = seq.upper().strip()
    seq = re.sub(r"[\s\-_,.;:|/\\]+", "", seq)
    return seq


def detect_issues(seq: str) -> list[str]:
    """
    Return a list of validation issues.
    """
    issues = []

    if not seq:
        issues.append("Sequence is empty after cleanup.")
        return issues

    illegal_chars = sorted(set(ch for ch in seq if ch not in ALL_BASES))
    if illegal_chars:
        issues.append(
            f"Illegal character(s) found: {', '.join(illegal_chars)}. "
            "Only A, C, G, T, U are allowed."
        )

    if "T" in seq and "U" in seq:
        issues.append("Sequence contains both T and U, so it is mixed DNA/RNA and ambiguous.")

    return issues


def infer_type(seq: str) -> str:
    """
    Infer whether the cleaned sequence is DNA or RNA.
    Returns: 'DNA', 'RNA', or 'AMBIGUOUS'
    """
    has_t = "T" in seq
    has_u = "U" in seq

    if has_t and not has_u:
        return "DNA"
    if has_u and not has_t:
        return "RNA"
    return "AMBIGUOUS"


def convert_sequence(seq: str, target: str) -> str:
    """
    Convert sequence to DNA or RNA.
    """
    if target == "dna":
        return seq.replace("U", "T")
    if target == "rna":
        return seq.replace("T", "U")
    raise ValueError(f"Unsupported target type: {target}")


def reverse_complement(seq: str, seq_type: str) -> str:
    """
    Reverse complement a DNA or RNA sequence.
    """
    if seq_type == "DNA":
        comp = str.maketrans("ACGT", "TGCA")
    elif seq_type == "RNA":
        comp = str.maketrans("ACGU", "UGCA")
    else:
        raise ValueError("Reverse complement requires a resolved DNA or RNA sequence type.")

    return seq.translate(comp)[::-1]


def format_block(title: str, seq: str) -> str:
    """
    Format sequence as an easy copy-paste block.
    """
    return f"{title}\n{seq}"


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Clean, validate, convert, and optionally reverse-complement a DNA/RNA sequence."
    )
    parser.add_argument(
        "sequence",
        help="Input nucleic acid sequence (DNA or RNA). Quotes recommended if it contains spaces."
    )
    parser.add_argument(
        "--to",
        choices=["dna", "rna"],
        required=True,
        help="Target output type: dna or rna."
    )
    parser.add_argument(
        "--revcomp",
        action="store_true",
        help="Return the reverse complement of the converted output sequence."
    )

    args = parser.parse_args()

    raw_seq = args.sequence
    cleaned_seq = clean_sequence(raw_seq)
    issues = detect_issues(cleaned_seq)

    print("=" * 72)
    print("Nucleic Acid Helper Result")
    print("=" * 72)
    print(f"Raw input:      {raw_seq}")
    print(f"Cleaned input:  {cleaned_seq}")
    print()

    # 1. legality check
    if issues:
        print("1. Input legality check")
        print("Status: INVALID")
        for issue in issues:
            print(f"- {issue}")
        print()
        print("No conversion was performed.")
        return 1

    input_type = infer_type(cleaned_seq)
    target_type = args.to.upper()

    # If only A/C/G present, type is ambiguous but still convertible
    if input_type == "AMBIGUOUS":
        input_type_desc = "AMBIGUOUS (contains no T/U distinction; compatible with both DNA and RNA)"
    else:
        input_type_desc = input_type

    converted_seq = convert_sequence(cleaned_seq, args.to)

    if args.revcomp:
        final_seq = reverse_complement(converted_seq, target_type)
    else:
        final_seq = converted_seq

    # 1. legality check
    print("1. Input legality check")
    print("Status: VALID")
    print(f"Detected input type: {input_type_desc}")
    print()

    # 2. conversion summary
    print("2. Conversion summary")
    print(f"Converted from: {input_type_desc}")
    print(f"Converted to:   {target_type}")
    print(f"Reverse complement applied: {'YES' if args.revcomp else 'NO'}")
    print(f"Input sequence:  {cleaned_seq}")
    print(f"Output sequence: {final_seq}")
    print()

    # 3. lengths
    print("3. Sequence lengths")
    print(f"Input length:  {len(cleaned_seq)}")
    print(f"Output length: {len(final_seq)}")
    print()

    # 4. easy copy/paste
    print("4. Copy-paste output")
    print("-" * 72)
    print(final_seq)
    print("-" * 72)

    return 0


if __name__ == "__main__":
    sys.exit(main())