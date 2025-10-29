#!/usr/bin/env python3
"""
Apply Swedish replacements for placeholder translations in the given XML file
using a curated Norwegian→Swedish TSV mapping.

Behavior:
  - Only touches swe <tg> blocks where any <t> ends with "_SWE".
  - For the corresponding mg, looks at the nob <tg>/<t> texts.
  - For each Norwegian <t>, if an exact mapping exists, collects the mapped
    Swedish translation(s). Deduplicates and sorts them (stable-ish).
  - If at least ONE mapped Swedish translation is found for the mg, replaces
    ALL swe placeholder <t> nodes in that tg with the collected Swedish <t>
    nodes.
  - If no mapped translations are found for that mg, the swe placeholder is
    left untouched.

Usage:
  python scripts/apply_swe_replacements.py \
      --input src/n_smamul.xml \
      --map inc/nob2swe_map.tsv \
      --output src/n_smamul.swe_applied.xml

Notes:
  - Mapping file format: TSV with two columns: Norwegian\tSwedish
    Swedish column may contain multiple values separated by ';'.
  - Exact string match on the Norwegian side after stripping whitespace.
  - POS handling: we keep the 'pos' value from the first existing swe<t> in that tg
    if available; else we fall back to the first Norwegian 't' pos.
  - The transformation is conservative: it never removes a swe tg unless it
    replaces it with mapped entries. Unmapped placeholders remain for manual review.
"""
import sys
import argparse
import xml.etree.ElementTree as ET

def parse_args():
    ap = argparse.ArgumentParser()
    ap.add_argument('--input', required=True, help='Path to source XML')
    ap.add_argument('--map', dest='map_path', required=True, help='TSV mapping: Norwegian\tSwedish(;(more))')
    ap.add_argument('--output', required=True, help='Path to write transformed XML')
    return ap.parse_args()

def load_map(path):
    m = {}
    with open(path, 'r', encoding='utf-8') as f:
        for raw in f:
            line = raw.strip()
            if not line or line.startswith('#'):
                continue
            # Support both real TAB and literal "\t" as separators
            if '\\t' in line and '\t' not in line:
                # Convert escaped tab to real tab to be tolerant
                line = line.replace('\\t', '\t')
            if '\t' not in line:
                # No delimiter found
                continue
            no, sv = line.split('\t', 1)
            no = no.strip().strip('"')
            sv = sv.strip()
            if not no or not sv:
                continue
            m[no] = [v.strip() for v in sv.split(';') if v.strip()]
    return m

def get_text(el):
    return (el.text or '').strip()

def endswith_swe(text: str) -> bool:
    return text.endswith('_SWE')

def main():
    args = parse_args()
    no2sv = load_map(args.map_path)
    print(f"Loaded mappings: {len(no2sv)} entries; has 'tilbakemelding': {'tilbakemelding' in no2sv}")

    tree = ET.parse(args.input)
    root = tree.getroot()

    ns_xml = '{http://www.w3.org/XML/1998/namespace}lang'

    replaced_mg = 0
    touched_mg = 0
    mgs_with_any_map = 0
    sample_logged = 0
    for e in root.findall('.//e'):
        mgs = e.findall('./mg')
        for mg in mgs:
            # Norwegian tg
            nob_tg = None
            for tg in mg.findall('./tg'):
                if tg.get(ns_xml) == 'nob':
                    nob_tg = tg
                    break
            if nob_tg is None:
                continue

            # Swedish tg
            swe_tg = None
            for tg in mg.findall('./tg'):
                if tg.get(ns_xml) == 'swe':
                    swe_tg = tg
                    break
            if swe_tg is None:
                continue

            swe_ts = swe_tg.findall('./t')
            swe_placeholders = [t for t in swe_ts if endswith_swe(get_text(t))]
            if not swe_placeholders:
                continue

            touched_mg += 1

            # Collect mapped Swedish candidates from Norwegian t's
            mapped_sv = []
            nob_ts = nob_tg.findall('./t')
            for t in nob_ts:
                src = get_text(t)
                if sample_logged < 20:
                    print(f"DEBUG nob t: '{src}'")
                    sample_logged += 1
                cand = no2sv.get(src)
                if cand:
                    mapped_sv.extend(cand)
            # Deduplicate while preserving order
            seen = set()
            mapped_sv_unique = []
            for sv in mapped_sv:
                if sv not in seen:
                    seen.add(sv)
                    mapped_sv_unique.append(sv)

            if not mapped_sv_unique:
                # No mapping => leave placeholders as-is
                continue

            mgs_with_any_map += 1

            # Decide pos to use for new Swedish t's
            pos_hint = None
            if swe_placeholders and swe_placeholders[0].get('pos'):
                pos_hint = swe_placeholders[0].get('pos')
            elif nob_ts and nob_ts[0].get('pos'):
                pos_hint = nob_ts[0].get('pos')

            # Remove existing t under swe tg
            for t in list(swe_tg.findall('./t')):
                swe_tg.remove(t)

            # Insert mapped Swedish t's
            for sv in mapped_sv_unique:
                t_el = ET.Element('t')
                if pos_hint:
                    t_el.set('pos', pos_hint)
                t_el.text = sv
                swe_tg.append(t_el)

            replaced_mg += 1

    tree.write(args.output, encoding='utf-8', xml_declaration=True)
    print(f"Swedish replacements applied to {replaced_mg} mg blocks (out of {touched_mg} with placeholders). Output: {args.output}")
    print(f"MGs with at least one Norwegian→Swedish mapping hit: {mgs_with_any_map}")

if __name__ == '__main__':
    main()
