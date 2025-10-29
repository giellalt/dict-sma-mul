#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script to replace Swedish translations ending with '_SWE' with proper Swedish translations.
Uses regex-based replacement to preserve original XML formatting.
"""

import re

# Dictionary mapping Norwegian to Swedish translations
nob_to_swe = {
    # Family terms
    "tilbakemelding": ["återkoppling", "respons"],
    "bestemor": ["farmor", "mormor"],
    "bestefar": ["farfar", "morfar"],
    "bestefars barnebarn": ["farfars barnbarn", "morfars barnbarn"],
    "tremenning": ["tremänning"],
    
    # Animals and nature
    "simle som skiller seg ut fra de andre": ["hona som sticker ut från de andra", "hona som avviker från de andra"],
    "aks": ["ax"],
    "heller": ["häll"],
    "allmue": ["allmoge"],
    "anker": ["ankare"],
    "ur": ["sten"],
    "utsiktspunkt": ["utsiktspunkt"],
    "sprengkulde": ["sträng kyla", "extrem köld"],
    "komag": ["komager", "finsko"],
    "barsok": ["barskosele"],
    "gang": ["gång"],
    "tannhull": ["tandhål", "hål i tanden"],
    "påståelighet": ["påstridighet", "envishet"],
    "nederste plass i gamma": ["nedersta platsen i kåtan"],
    "skohøybunt": ["knippe höskogräs"],
    "utkaster": ["utkastare"],
    "rest": ["rest"],
    "hansketommel": ["vanttumme"],
    "kull": ["kull", "avkomma"],
    "neverfakkel": ["näversticka", "fackla av näver"],
    "fiskemat": ["fiskemat", "bete"],
    "overtelne": ["förtent"],
    "svange": ["svängrem"],
    "kanting av tøy eller skinn": ["kantning av tyg eller skinn"],
    "gode": ["goda"],
    "velgjerning": ["välgärning"],
    "mjølkekjørle": ["mjölkkärl", "mjölkskål"],
    "person som melker": ["mjölkare"],
    "vidjebånd": ["vidjeband"],
    "matplassen i gamma": ["matplatsen i kåtan"],
    "åpning ovenfor matplassen i gamma": ["öppning ovanför matplatsen i kåtan"],
    "smurning": ["smörjning"],
    "skobåndende": ["skosnöresände"],
    "ås": ["ås"],
    "bud": ["bud", "budskap"],
    "kløv": ["klöv"],
    "myrflo": ["myrmark"],
    "moltemyr": ["hjortronmyr"],
    "vindskjerm": ["vindskydd"],
    "binne": ["krubba", "hinder"],
    "bot": ["bot"],
    "sanser": ["sinnen"],
    "føre": ["före"],
    "vær": ["väder"],
    "fjellbrem": ["fjällbräken"],
    "helbreder": ["helbrägdagörare", "läkare"],
    "kurering": ["bot", "helande"],
    "tvare": ["tvär"],
    "fornødenheter": ["förnödenheter"],
    "torvhytte": ["torvkoja", "torvhydda"],
    "tinghus": ["tingshus"],
    "hinmannen": ["hinnen"],
    "lapp": ["lapp", "same"],
    "skinnet på undersiden av reinens hode": ["skinnet på undersidan av renens huvud"],
    "støtte": ["stöd"],
    "lite skinn": ["litet skinn"],
    "torsdag": ["torsdag"],
    "skinn": ["skinn"],
    "dusin": ["dussin"],
    "høviskhet": ["hövlighet"],
    "domstol": ["domstol"],
    "krig": ["krig"],
    "kriger": ["krigare"],
    "filter": ["filter"],
    "noe som tar imot eller stopper": ["något som tar emot eller stoppar"],
    "rolle": ["rulle", "roll"],
    "hindring": ["hinder"],
    "tønne": ["tunna"],
    "reparatør": ["reparatör"],
    "lege": ["läkare"],
    "kløvunderlag": ["klövunderlag"],
    "erfaring": ["erfarenhet"],
    "ansvar": ["ansvar"],
    "punkt": ["punkt"],
    "uttrykk": ["uttryck"],
    "dønning": ["dyning"],
    "fortjeneste": ["förtjänst"],
    "ferdigkokt kjøtt": ["färdigkokt kött"],
    "beskjed": ["besked"],
    "budbærer": ["budbärare"],
    "larm": ["larm", "oväsen"],
    "kragefett": ["kroppsfett", "fett"],
    "e-post": ["e-post"],
    "grunn": ["grund"],
    "entusiasme": ["entusiasm"],
    "eiendom": ["egendom"],
    "reinhjord": ["renhjord"],
    "ære": ["ära"],
    "forelder": ["förälder"],
    "gods": ["gods"],
    "vare": ["vara"],
    "eksponent": ["exponent"],
    "samarbeid": ["samarbete"],
    "ekteskap": ["äktenskap"],
    "enhet": ["enhet"],
    "samfunnsliv": ["samhällsliv"],
    "samfunn": ["samhälle"],
    "felles mål": ["gemensamt mål"],
    "helhet": ["helhet"],
    "første regndråpen": ["första regndroppen"],
    "fang": ["famn"],
    "jur": ["famn"],
    "utvikling": ["utveckling"],
    "fadder": ["fadder"],
    "fagstoff": ["kursmaterial", "ämnesstoff"],
    "fagområde": ["sakområde", "ämnesområde"],
    "bærerem": ["bärrem"],
    "maktfaktor": ["maktfaktor"],
    "reisefølge": ["resesällskap", "följe"],
    "vindskydd": ["vindskydd"],
    "favn": ["famn"],
    "reisende": ["resande"],
    "reise": ["resa"],
    "fat": ["fat"],
    "hunnrype": ["hönsripa"],
    "sameluebånd": ["sammetsband", "samiskt luaband"],
    "flesk": ["fläsk"],
    "hær": ["här"],
    "fred": ["fred"],
    "travelhet": ["travla tider", "stress"],
    "stresskoffert": ["stressväska"],
    "familie": ["familj"],
    "husstand": ["hushåll"],
    "trollunge": ["trollunge"],
    "foss": ["fors"],
    "fylke": ["län"],
    "fylkesting": ["länsting"],
    "fylkeskommune": ["länskommun"],
    "skyld": ["skuld"],
    "fogd": ["fogde"],
    "fiendehær": ["fiendehär"],
    "tjener": ["tjänare"],
    "øyeeple": ["ögonglob"],
    "pupill": ["pupill"],
    "sladder": ["skvaller"],
    "lydform": ["ljudform"],
    "berøring": ["beröring"],
    "ektemann": ["make", "äkta man"],
    "skallesko": ["skalsko"],
    "lik": ["lik"],
    "reinflokk": ["renflock"],
    "mannfolk": ["manfolk"],
    "gås": ["gås"],
    "gate": ["gata"],
    "korsrygg på slakt": ["korsrygg på slakt"],
    "kanne": ["kanna"],
    "nylig kastrert hannrein": ["nyligen kastrerad renoxe"],
    "rypesnare": ["ripsnara"],
    "førerrein": ["ledren"],
    "tam rein": ["tam ren"],
    "forganer": ["förgängare"],
    "trang til å gjespe": ["behov att gäspa"],
    "møte": ["möte"],
    "stevnemøte": ["stämma"],
    "treffsted": ["träffpunkt", "träffställe"],
    "negl": ["nagel"],
    "labb": ["tass"],
    "delen av bellingen som er nærmest kloven": ["delen av bellingen som är närmast klöven"],
    "ryggsekk med lokk": ["ryggsäck med lock"],
    "ryggsekklokk": ["ryggsäcklock"],
    "rykende ild uten flamme": ["rykande eld utan låga"],
    "september": ["september"],
    "reingjerde": ["renstängsel"],
    "leke": ["lek"],
    "pose til sysaker": ["påse för sysaker"],
    "en som er stam": ["en som är stam"],
    "person som er stam": ["person som är stam"],
    "sted i elv med sterk strøm": ["plats i älv med stark ström"],
    "strøm i bekk": ["ström i bäck"],
    "stokk": ["stock"],
    "fornøyelse": ["nöje"],
    "januar": ["januari"],
    "mellomrom": ["mellanrum"],
    "midt på dagen": ["mitt på dagen"],
    "middag": ["middag"],
    "mellomtrinn": ["mellanstadiet"],
    "mellomspråk": ["mellanspråk"],
    "midnatt": ["midnatt"],
    "fyrtøy": ["elddon", "tändare"],
    "lyn": ["blixt"],
    "forbindelse": ["förbindelse"],
    "dyrelunge": ["djurlunga"],
    "glede": ["glädje"],
    "rein som drar pulk": ["ren som drar pulka"],
    "del av seletøyet": ["del av sältyget"],
    "seletøy": ["seltyg"],
}

def process_entry(entry_text):
    """
    Process a single entry and replace Swedish translations ending with _SWE.
    Returns the modified entry text and whether any changes were made.
    """
    changes_made = []
    modified_entry = entry_text
    
    # Pattern to find Norwegian translations
    nob_pattern = r'<tg xml:lang="nob">\s*<t[^>]*>([^<]+)</t>'
    
    # Find all Norwegian translations in this entry
    nob_matches = re.findall(nob_pattern, entry_text)
    
    if not nob_matches:
        return modified_entry, changes_made
    
    # Pattern to find Swedish translations ending with _SWE
    swe_pattern = r'(<tg xml:lang="swe">.*?</tg>)'
    
    def replace_swe_tg(match):
        tg_content = match.group(1)
        
        # Check if this tg has any _SWE endings
        if '_SWE' not in tg_content:
            return tg_content
        
        # Extract the t elements with _SWE
        t_pattern = r'<t ([^>]*)>([^<]+)_SWE</t>'
        t_matches = list(re.finditer(t_pattern, tg_content))
        
        if not t_matches:
            return tg_content
        
        # Try to find Swedish translation for the first Norwegian word
        for nob_word in nob_matches:
            if nob_word.strip() in nob_to_swe:
                swe_translations = nob_to_swe[nob_word.strip()]
                
                # Build replacement
                for t_match in t_matches:
                    attrs = t_match.group(1)
                    original_text = t_match.group(2) + '_SWE'
                    
                    # Create new t elements
                    new_t_elements = '\n            '.join([f'<t {attrs}>{swe_trans}</t>' for swe_trans in swe_translations])
                    
                    # Replace in tg_content
                    old_t = t_match.group(0)
                    tg_content = tg_content.replace(old_t, new_t_elements)
                    changes_made.append(f"Changed '{original_text}' to {swe_translations} (nob: {nob_word.strip()})")
                
                break
        
        return tg_content
    
    modified_entry = re.sub(swe_pattern, replace_swe_tg, modified_entry, flags=re.DOTALL)
    
    return modified_entry, changes_made

def process_xml_file(input_file):
    """
    Process the XML file and replace Swedish translations ending with _SWE.
    Modifies the file in place.
    """
    print("Reading file...")
    with open(input_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    print("Processing entries...")
    
    # Pattern to match each entry
    entry_pattern = r'(<e[^>]*>.*?</e>)'
    
    total_changes = []
    entry_count = 0
    
    def replace_entry(match):
        nonlocal entry_count, total_changes
        entry_count += 1
        entry_text = match.group(1)
        modified_entry, changes = process_entry(entry_text)
        total_changes.extend(changes)
        return modified_entry
    
    modified_content = re.sub(entry_pattern, replace_entry, content, flags=re.DOTALL)
    
    print(f"Writing changes to file...")
    with open(input_file, 'w', encoding='utf-8') as f:
        f.write(modified_content)
    
    print(f"\n{'='*60}")
    print(f"Processing complete!")
    print(f"Entries processed: {entry_count}")
    print(f"Changes made: {len(total_changes)}")
    print(f"File updated: {input_file}")
    print(f"{'='*60}")
    
    if total_changes:
        print(f"\nFirst 10 changes:")
        for i, change in enumerate(total_changes[:10], 1):
            print(f"  {i}. {change}")

if __name__ == "__main__":
    input_file = "/Users/smo036/langtech/gut/giellalt/dict-sma-mul/src/n_smamul.xml"
    
    print("Starting to process Swedish translations...")
    print(f"This will modify the file: {input_file}")
    
    response = input("Do you want to continue? (yes/no): ")
    if response.lower() in ['yes', 'y']:
        process_xml_file(input_file)
    else:
        print("Operation cancelled.")
