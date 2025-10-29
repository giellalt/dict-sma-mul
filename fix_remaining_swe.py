#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Manual additions to fix remaining _SWE translations.
This script adds translations that require context or special handling.
"""

import re

# Additional translations needed
additional_nob_to_swe = {
    "anker": ["ankare"],
    "steinur": ["ur", "stensamling"],
    "kull": ["kull"],  # when context is "om avkom"
    "overtelne": ["förtentad", "förtent"],
    "mjølkekjørle": ["mjölkkärl"],
    "matplassen i gamma": ["matplatsen i kåtan"],
    "åpning ovenfor matplassen i gamma": ["öppning ovanför matplatsen i kåtan"],
    "ås": ["ås"],
    "vindskjerm": ["vindskydd"],
    "torvhytte": ["torvkoja"],
}

def fix_remaining_swe(input_file):
    """Fix remaining _SWE entries with manual translations"""
    
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    changes = []
    
    # Fix specific patterns
    # 1. anker with re element
    pattern1 = r'(<tg xml:lang="swe">)\s*(<re>rommål_SWE</re>)\s*(<t pos="N">)anker_SWE(</t>)'
    replacement1 = r'\1\n            <re>rymdmått</re>\n            \3ankare\4'
    if re.search(pattern1, content):
        content = re.sub(pattern1, replacement1, content)
        changes.append("Fixed 'anker' with rommål context")
    
    # 2. steinur -> ur
    pattern2 = r'(<tg xml:lang="swe">)\s*(<t pos="N">)ur_SWE(</t>)'
    replacement2 = r'\1\n            \2ur\3\n            \2stensamling\3'
    if re.search(pattern2, content):
        content = re.sub(pattern2, replacement2, content)
        changes.append("Fixed 'steinur' -> 'ur/stensamling'")
    
    # 3. kull with re element about offspring
    pattern3 = r'(<tg xml:lang="swe">)\s*(<re>om avkomma</re>)\s*(<t pos="N">)kull_SWE(</t>)'
    replacement3 = r'\1\n            \2\n            \3kull\4\n            \3avkomma\4'
    if re.search(pattern3, content):
        content = re.sub(pattern3, replacement3, content)
        changes.append("Fixed 'kull' with avkomma context")
    
    # 4. overtelne
    pattern4 = r'(<t pos="N">)overtelne_SWE(</t>)'
    replacement4 = r'\1förtentad\2\n            \1förtent\2'
    if re.search(pattern4, content):
        content = re.sub(pattern4, replacement4, content)
        changes.append("Fixed 'overtelne' -> 'förtentad/förtent'")
    
    # 5. mjølkekjørle
    pattern5 = r'(<t pos="N">)mjølkekjørle_SWE(</t>)'
    replacement5 = r'\1mjölkkärl\2\n            \1mjölkskål\2'
    if re.search(pattern5, content):
        content = re.sub(pattern5, replacement5, content)
        changes.append("Fixed 'mjølkekjørle' -> 'mjölkkärl/mjölkskål'")
    
    # 6. matplassen i gamma
    pattern6 = r'(<t pos="Phrase">)matplassen i gamma_SWE(</t>)'
    replacement6 = r'\1matplatsen i kåtan\2'
    if re.search(pattern6, content):
        content = re.sub(pattern6, replacement6, content)
        changes.append("Fixed 'matplassen i gamma' -> 'matplatsen i kåtan'")
    
    # 7. åpning ovenfor matplassen i gamma
    pattern7 = r'(<t pos="Phrase">)åpning ovenfor matplassen i gamma_SWE(</t>)'
    replacement7 = r'\1öppning ovanför matplatsen i kåtan\2'
    if re.search(pattern7, content):
        content = re.sub(pattern7, replacement7, content)
        changes.append("Fixed 'åpning ovenfor matplassen i gamma' -> 'öppning ovanför matplatsen i kåtan'")
    
    # 8. ås
    pattern8 = r'(<t pos="N">)ås_SWE(</t>)'
    replacement8 = r'\1ås\2'
    if re.search(pattern8, content):
        content = re.sub(pattern8, replacement8, content)
        changes.append("Fixed 'ås' -> 'ås'")
    
    # 9. vindskjerm
    pattern9 = r'(<t pos="N">)vindskjerm_SWE(</t>)'
    replacement9 = r'\1vindskydd\2'
    if re.search(pattern9, content):
        content = re.sub(pattern9, replacement9, content)
        changes.append("Fixed 'vindskjerm' -> 'vindskydd'")
    
    # 10. torvhytte
    pattern10 = r'(<t pos="N">)torvhytte_SWE(</t>)'
    replacement10 = r'\1torvkoja\2\n            \1torvhydda\2'
    if re.search(pattern10, content):
        content = re.sub(pattern10, replacement10, content)
        changes.append("Fixed 'torvhytte' -> 'torvkoja/torvhydda'")
    
    # Write back
    with open(input_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print(f"Fixed {len(changes)} remaining _SWE entries:")
    for change in changes:
        print(f"  - {change}")
    
    # Check if any _SWE remain
    remaining = re.findall(r'_SWE', content)
    print(f"\nRemaining _SWE occurrences: {len(remaining)}")
    
    if remaining:
        # Show where they are
        lines = content.split('\n')
        for i, line in enumerate(lines, 1):
            if '_SWE' in line:
                print(f"  Line {i}: {line.strip()}")

if __name__ == "__main__":
    input_file = "/Users/smo036/langtech/gut/giellalt/dict-sma-mul/src/n_smamul.xml"
    
    print("Fixing remaining _SWE translations...")
    fix_remaining_swe(input_file)
    print("\nDone!")
