#!/bin/sh

# Compiles the large lexicon (DictEst) from multiple sources.

# The lexicon must be sorted according to the Estonian locale
# ABCDEFGHIJKLMNOPQRSŠŽTUVWÕÄÖÜXY
#
# Check if you have it:
#   locale -a | grep et_
# If not, then check if it is supported:
#   less /usr/share/i18n/SUPPORTED | grep "et_"
# If yes, then generate it:
#   sudo locale-gen et_EE.UTF-8

tools=${GF_EST_SRC}/../tools/lexicon/

make_dictest=$tools/make-dictest.py
estcglex_to_gf=$tools/estcglex-to-gf.py
emwv_to_gf=$tools/emwv-to-gf.py
wrap_as_gf_module=$tools/wrap_as_gf_module.py

data=${GF_EST_SRC}/data/
grammar=${GF_EST_SRC}/estonian/
# The resources directory is currently not under version control
# It needs to have the files (see also get-resources.bash):
#   - emwv/DB_EMWV_2008.txt (Estonian multi-word units DB)
#     http://www.cl.ut.ee/ressursid/pysiyhendid/DB_EMWV_2008.zip
resources=${GF_EST_SRC}/resources/

echo "Verbs"
cat $data/abileks_utf8.lx | $estcglex_to_gf --forms $data/abileks.verbs.8forms.csv > out_estcglex.tsv 2> err_estcglex.txt

echo "Multi-word verbs"
cat $resources/emwv/DB_EMWV_2008.txt | $emwv_to_gf -f $data/abileks.verbs.8forms.csv > out_mwv.tsv 2> err_mwv.txt

echo "Adverbs"
$make_dictest --pos-tags=b | cut -f2,3 | sort | uniq > out_adv.tsv 2> err_adv.txt

echo "Nouns"
$make_dictest --pos-tags=n | cut -f2,3 | sort | uniq > out_nouns.tsv 2> err_nouns.txt

echo "Adjectives"
$make_dictest --pos-tags=a | cut -f2,3 | sort | uniq > out_adj.tsv 2> err_adj.txt

# Convert into GF
cat out_estcglex.tsv out_mwv.tsv out_adv.tsv out_nouns.tsv out_adj.tsv | LC_ALL=et_EE.utf8 sort -k1 | uniq | cut -f2 | $wrap_as_gf_module

echo "Errors:"
cat err_*.txt

echo "Trying to open the lexicon using GF:"
gf +RTS -K50M -RTS --retain DictEst.gf
