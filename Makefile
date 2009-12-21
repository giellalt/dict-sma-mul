# This is a makefile that builds the sma-nob translation parser

# It should be rewritten with Twig or something similar instead of 
# the shellscript we have now

# =========== Tools: ============= #
LEXC = lexc -utf8
XFST = xfst -utf8
XSLT = /opt/local/share/java/saxon8.jar
XQL  = java net.sf.saxon.Query
JARF = -jar
SSH  = /usr/bin/ssh

# =========== Paths & files: ============= #
GTHOME      = ../../../gt
SMATESTING  = $(GTHOME)/sma/testing
SMANOBMAC   = deliv/macdict/objects
SMANOBNAME  = Sørsamisk-norsk ordbok.dictionary
SMANOBZIP   = smanob-mac.dictionary.tgz
UPLOADDIR   = sd@giellatekno.uit.no:xtdoc/sd/src/documentation/content/xdocs
DOWNLOADDIR = http://www.divvun.no/static_files
ADJ         = src/a_smanob.xml
ADV         = src/adv_smanob.xml
NOUN        = src/n_smanob.xml
#NOUNC       = src/n_smanob.xml
NOUNP       = src/npl_smanob.xml
OTHER       = src/xxx_smanob.xml
VERB        = src/v_smanob.xml
PRON        = src/pron_smanob.xml
CC          = src/cc_smanob.xml
CS          = src/cs_smanob.xml
INTERJ      = src/i_smanob.xml
PCLE        = src/pcle_smanob.xml
# Trond trying to be smart here:
SN_XML      = ADJ ADV NOUNC NOUNP OTHER VERB
#SN_XML      = smanob.xml
SN_XSL      = smanob.xsl
SN_LEXC     = smanob.lexc
SN_HTML     = smanob.html
SN_FST      = smanob.fst
S_DIC       = sma.dic
S_FST       = smadic.fst
SRC         = src
BIN         = bin
SCRIPTS     = scripts
BEGIN       = @echo "*** Generating the $@-file ***"
END         = @echo "Done."

# =========== Other: ============= #
DATE = $(shell date +%Y%m%d)

# fst for the sma-nob dictionary

#Pseudocode:											    
#Make a lexc file:										    
#Print the first line: LEXICON Root						    
#Then, for each entry, make lines of the format smalemma:firstnobtranslation # ;
#Then print the result to file.
#Then make xfst read it with the command read lexc.
# The trick is that only the first <t node may be chosen, there may be several.

# Target to create a fst transducer picking just the first translation of each 
# lemma. And while we're at it, we invert it as well.

# Create the smanob.fst-file
$(SN_FST): $(SN_LEXC)
	@echo
	$(BEGIN)
	@echo
	@printf "read lexc < $(BIN)/$< \n\
	save $(BIN)/ismanob.fst \n\
	invert net \n\
	save $(BIN)/$@ \n\
	quit \n" > ../tmp/smanob-save-script
	$(XFST) < ../tmp/smanob-save-script
	@rm -rf ../tmp/smanob-save-script
	@echo
	$(END)
	@echo

# # fst for the Sámi words in the dictionary
# # Pseudocode:
# # Pick the lemmas, and print them to list
# # Read the list into xfst
# # Save as an automaton.
# # The perlscript for glossing should use smanob.lexc or something similar.
# #
# # Create the smadic.fst-file
$(S_FST): $(S_DIC)
	@echo
	$(BEGIN)
	@echo
	@printf "read text < $(BIN)/$< \n\
	save stack $> \n\
	quit \n" > ../tmp/smadic-save-script
	$(XFST) < ../tmp/smadic-save-script
	@rm -f ../tmp/smadic-save-script
	@rm -f $(BIN)/$<

# # Create the sma.dic file from the smanob.xml-file
$(S_DIC): $(SN_XML)
	@echo
	$(BEGIN)
	@java $(JARF) $(XSLT) $(BIN)/$(SN_XML) $(SCRIPTS)/get-lemma.xsl > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the lexc file from the smanob.xml-file (using XQuery 1.0)
$(SN_LEXC): $(SN_XML)
	@echo
	$(BEGIN)
	@$(XQL) $(SCRIPTS)/smanob-pairs.xql smanob=../$(BIN)/$< > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the lexc file from the smanob.xml-file (using XSLT 2.0, which is not as nice as XQuery)
# $(SN_LEXC): $(SN_XML)
# 	@echo
# 	$(BEGIN)
# 	@java $(JARF) $(XSLT) $(BIN)/$< $(SCRIPTS)/smanob-pairs.xsl > $(BIN)/$@
# 	@echo
# 	$(END)
# 	@echo

# Create a simple HTML file for local browsing of the whole dictionary
$(SN_HTML): $(SN_XML) $(SCRIPTS)/$(SN_XSL)
	@echo
	$(BEGIN)
	@java $(JARF) $(XSLT) $(BIN)/$(SN_XML) $(SCRIPTS)/$(SN_XSL) > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the smanob.xml-file by unifing the individual parts (using XQuery 1.0)
$(SN_XML):
	@echo
	$(BEGIN)
	@$(XQL) $(SCRIPTS)/collect-smanob-parts.xql \
	 adj=../$(SRC)/$(ADJ) noun=../$(SRC)/$(NOUN) \
	 other=../$(SRC)/$(OTHER) verb=../$(SRC)/$(VERB) > $(BIN)/$@
	@echo
	$(END)
	@echo

# Create the smanob.xml-file by unifing the individual parts (using XSLT 2.0, which is not as nice as XQuery)
# $(SN_XML):
# 	@echo
# 	$(BEGIN)
# 	@java $(JARF) $(XSLT) $(SCRIPTS)/dummy.xml $(SCRIPTS)/collect-smanob-parts.xsl \
# 	 adj=../$(SRC)/$(ADJ) adv=../$(SRC)/$(ADV) noun=../$(SRC)/$(NOUN) \
# 	 other=../$(SRC)/$(OTHER) verb=../$(SRC)/$(VERB) > $(BIN)/$@
# 	@echo
# 	$(END)
# 	@echo




# Target to make a MacOS X/Dictionary.app compatible dictionary bundle:
macdict: macdict/smanob.xml
macdict/smanob.xml: src/smanob.xml \
					scripts/smanob2macdict.xsl \
					scripts/add-paradigm.xsl
	@echo
	@echo "*** Extracting words from dictionary file. ***"
	@echo
	grep '<l pos' $< | \
	   perl -pe 's/^.*pos="([^"]+)">(.+)<.*$$/\2	\1/' | \
	   grep '	[nav]$$' | grep -v '^-' | sort -u \
	   > $(SMATESTING)/dictwords.txt
	@echo
	@echo "*** Generating paradigms. ***"
	@echo
	cd $(SMATESTING) && ./gen-paradigms.sh dictwords.txt
	@echo
	@echo "*** Building smanob.xml for MacOS X Dictionary ***" 
	@echo
	java -Xmx1024m \
		org.apache.xalan.xslt.Process \
		-in  $< \
		-out $@.tmp \
		-xsl scripts/add-paradigm.xsl \
		-param gtpath $(SMATESTING)
	@xsltproc scripts/smanob2macdict.xsl $@.tmp > $@
	rm -f $@.tmp
	@cd deliv/macdict && make

# Target to upload a MacOSX dictionary module
upload-macdict:
	@echo
	@echo "*** TAR-ing and ZIP-ing smanob Mac dictionary ***"
	@echo
	tar -czf $(SMANOBZIP) "$(SMANOBMAC)/$(SMANOBNAME)"
	@echo
	@echo "*** Uploading smanob Mac dictionary to www.divvun.no ***"
	@echo
	@scp $(SMANOBZIP) $(UPLOADDIR)/static_files/$(DATE)-$(SMANOBZIP)
	@$(SSH) sd@divvun.no \
		"cd staticfiles/ && ln -sf $(DATE)-$(SMANOBZIP) $(SMANOBZIP)"
	@echo
	@echo "*** New zip file for smanob Mac dictionary now available at: ***"
	@echo
	@echo "$(DOWNLOADDIR)/$(DATE)-$(SMANOBZIP)"
	@echo
	@echo "*** Permlink to newest version is always: ***"
	@echo
	@echo "$(DOWNLOADDIR)/$(SMANOBZIP)"
	@echo

clean:
	@rm -f $(BIN)/*fst $(BIN)/*dic $(BIN)/*lexc $(BIN)/*list $(BIN)/*html $(BIN)/*xml $(BIN)/*txt


