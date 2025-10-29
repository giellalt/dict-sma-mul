#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script to translate remaining _SWE entries using Google Translate.
Translates Norwegian words to Swedish and replaces _SWE placeholders.
"""

import re
import time
from deep_translator import GoogleTranslator

def extract_entries_with_swe(content):
    """Extract all entries that contain _SWE in Swedish translations"""
    entries_with_swe = []
    
    # Pattern to match each entry
    entry_pattern = r'<e[^>]*>.*?</e>'
    entries = re.finditer(entry_pattern, content, flags=re.DOTALL)
    
    for entry_match in entries:
        entry_text = entry_match.group(0)
        
        # Check if this entry has _SWE
        if '_SWE' in entry_text:
            entries_with_swe.append({
                'full_text': entry_text,
                'start': entry_match.start(),
                'end': entry_match.end()
            })
    
    return entries_with_swe

def extract_norwegian_word(entry_text):
    """Extract the main Norwegian translation from an entry"""
    # Find tg element with xml:lang="nob"
    nob_pattern = r'<tg xml:lang="nob">.*?</tg>'
    nob_match = re.search(nob_pattern, entry_text, flags=re.DOTALL)
    
    if not nob_match:
        return None
    
    nob_content = nob_match.group(0)
    
    # Extract the first <t> element (ignoring <re> elements)
    t_pattern = r'<t[^>]*>([^<]+)</t>'
    t_match = re.search(t_pattern, nob_content)
    
    if t_match:
        return t_match.group(1).strip()
    
    return None

def translate_to_swedish(norwegian_text, translator=None):
    """Translate Norwegian text to Swedish using Google Translate"""
    try:
        translation = GoogleTranslator(source='no', target='sv').translate(norwegian_text)
        return translation
    except Exception as e:
        print(f"Translation error for '{norwegian_text}': {e}")
        return None

def replace_swe_in_entry(entry_text, swedish_translation):
    """Replace _SWE placeholder with proper Swedish translation"""
    
    # Pattern to find Swedish tg elements with _SWE
    swe_tg_pattern = r'(<tg xml:lang="swe">)(.*?)(</tg>)'
    
    def replace_tg(match):
        tg_start = match.group(1)
        tg_content = match.group(2)
        tg_end = match.group(3)
        
        # Check if this tg has _SWE
        if '_SWE' not in tg_content:
            return match.group(0)
        
        # Pattern to find t elements with _SWE
        t_pattern = r'<t ([^>]*)>([^<]+)_SWE</t>'
        
        def replace_t(t_match):
            attrs = t_match.group(1)
            # Use the Google Translate result
            return f'<t {attrs}>{swedish_translation}</t>'
        
        # Replace all _SWE occurrences in t elements
        new_tg_content = re.sub(t_pattern, replace_t, tg_content)
        
        # Also handle _SWE in <re> elements
        re_pattern = r'<re>([^<]+)_SWE</re>'
        new_tg_content = re.sub(re_pattern, lambda m: f'<re>{swedish_translation}</re>', new_tg_content)
        
        return tg_start + new_tg_content + tg_end
    
    return re.sub(swe_tg_pattern, replace_tg, entry_text, flags=re.DOTALL)

def process_file_with_google_translate(input_file, max_translations=100):
    """
    Process the XML file and translate _SWE entries using Google Translate.
    
    Args:
        input_file: Path to the XML file
        max_translations: Maximum number of translations to perform (to avoid rate limits)
    """
    
    print(f"Reading file: {input_file}")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    print("Extracting entries with _SWE...")
    entries_with_swe = extract_entries_with_swe(content)
    print(f"Found {len(entries_with_swe)} entries with _SWE")
    
    if len(entries_with_swe) > max_translations:
        print(f"\nLimiting to first {max_translations} translations (to avoid rate limits)")
        entries_with_swe = entries_with_swe[:max_translations]
    
    # Process each entry
    translations_made = 0
    failed_translations = []
    
    # Track all replacements
    replacements = []
    
    for i, entry_data in enumerate(entries_with_swe, 1):
        entry_text = entry_data['full_text']
        
        # Extract Norwegian word
        norwegian_word = extract_norwegian_word(entry_text)
        
        if not norwegian_word:
            print(f"{i}. No Norwegian word found in entry")
            continue
        
        # Translate to Swedish
        print(f"{i}/{len(entries_with_swe)}: Translating '{norwegian_word}'...", end=' ')
        swedish_translation = translate_to_swedish(norwegian_word)
        
        if swedish_translation:
            print(f"→ '{swedish_translation}'")
            
            # Replace _SWE with translation
            new_entry_text = replace_swe_in_entry(entry_text, swedish_translation)
            
            # Store replacement
            replacements.append({
                'old': entry_text,
                'new': new_entry_text,
                'norwegian': norwegian_word,
                'swedish': swedish_translation
            })
            
            translations_made += 1
            
            # Small delay to avoid rate limiting
            time.sleep(0.5)
        else:
            print("FAILED")
            failed_translations.append(norwegian_word)
    
    # Apply all replacements to content
    print(f"\nApplying {len(replacements)} replacements...")
    for replacement in replacements:
        content = content.replace(replacement['old'], replacement['new'], 1)
    
    # Write back to file
    print(f"Writing changes to file...")
    with open(input_file, 'w', encoding='utf-8') as f:
        f.write(content)
    
    # Summary
    print(f"\n{'='*60}")
    print(f"Translation complete!")
    print(f"Successful translations: {translations_made}")
    print(f"Failed translations: {len(failed_translations)}")
    print(f"File updated: {input_file}")
    print(f"{'='*60}")
    
    if failed_translations:
        print(f"\nFailed to translate:")
        for word in failed_translations[:20]:
            print(f"  - {word}")
        if len(failed_translations) > 20:
            print(f"  ... and {len(failed_translations) - 20} more")

if __name__ == "__main__":
    import sys
    
    input_file = "/Users/smo036/langtech/gut/giellalt/dict-sma-mul/src/n_smamul.xml"
    
    # Check if deep-translator is installed
    try:
        from deep_translator import GoogleTranslator
    except ImportError:
        print("Error: deep-translator library not installed")
        print("Install with: pip3 install deep-translator")
        sys.exit(1)
    
    # Ask for confirmation
    print("This will translate Norwegian words to Swedish using Google Translate")
    print(f"and replace _SWE placeholders in: {input_file}")
    
    # Get number of translations to do
    max_trans = input("\nHow many translations to perform? (default 100, 'all' for all): ").strip()
    
    if max_trans.lower() == 'all':
        max_trans = 999999
    elif max_trans == '':
        max_trans = 100
    else:
        try:
            max_trans = int(max_trans)
        except:
            max_trans = 100
    
    response = input(f"Continue with up to {max_trans} translations? (yes/no): ")
    if response.lower() in ['yes', 'y']:
        process_file_with_google_translate(input_file, max_trans)
    else:
        print("Operation cancelled.")
