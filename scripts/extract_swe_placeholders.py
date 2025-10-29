#!/usr/bin/env python3
"""
Extract all Swedish placeholder translations (ending with _SWE) from a given
multilingual dictionary XML file, together with their Sámi lemma and the
Norwegian tg translations in the same mg. Output a TSV for review.

Usage:
  python scripts/extract_swe_placeholders.py src/n_smamul.xml inc/swe_placeholders.tsv

Notes:
  - Only swe <tg> blocks where any <t> text ends with "_SWE" are included.
  - Each row represents one mg block with at least one swe placeholder.
  - Columns:
      lemma	mg_index	pos_hint	nob_ts	swe_placeholders
    where nob_ts and swe_placeholders are semicolon-separated lists.
"""
import sys
import os
import xml.etree.ElementTree as ET

def endswith_swe(text: str) -> bool:
    if text is None:
        return False
    return text.strip().endswith("_SWE")

def get_text(el):
    return (el.text or "").strip()

def main(inp: str, outp: str):
    tree = ET.parse(inp)
    root = tree.getroot()

    rows = []
    for e in root.findall('.//e'):
        l_el = e.find('./lg/l')
        lemma = get_text(l_el) if l_el is not None else ''
        mgs = e.findall('./mg')
        for idx, mg in enumerate(mgs, start=1):
            # find Norwegian tg in this mg
            nob_tg = None
            for tg in mg.findall('./tg'):
                if tg.get('{http://www.w3.org/XML/1998/namespace}lang') == 'nob':
                    nob_tg = tg
                    break
            nob_ts = []
            pos_hint = ''
            if nob_tg is not None:
                for t in nob_tg.findall('./t'):
                    nob_ts.append(get_text(t))
                    # capture a pos hint if available
                    if not pos_hint:
                        pos_hint = (t.get('pos') or '')

            # find Swedish tg with placeholders
            swe_tg = None
            for tg in mg.findall('./tg'):
                if tg.get('{http://www.w3.org/XML/1998/namespace}lang') == 'swe':
                    swe_tg = tg
                    break
            if swe_tg is None:
                continue

            swe_placeholders = [get_text(t) for t in swe_tg.findall('./t') if endswith_swe(get_text(t))]
            if swe_placeholders:
                rows.append((lemma, idx, pos_hint, '; '.join([t for t in nob_ts if t]), '; '.join(swe_placeholders)))

    os.makedirs(os.path.dirname(outp), exist_ok=True)
    with open(outp, 'w', encoding='utf-8') as f:
        f.write('lemma\tmg_index\tpos_hint\tnob_ts\tswe_placeholders\n')
        for lemma, idx, pos_hint, nob_ts_joined, swe_ph in rows:
            f.write(f"{lemma}\t{idx}\t{pos_hint}\t{nob_ts_joined}\t{swe_ph}\n")

    print(f"Wrote {len(rows)} rows to {outp}")

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: python scripts/extract_swe_placeholders.py <input_xml> <output_tsv>")
        sys.exit(1)
    main(sys.argv[1], sys.argv[2])
