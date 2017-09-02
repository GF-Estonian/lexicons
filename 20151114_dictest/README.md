Large monolingual lexicon DictEst
=================================

Introduction
------------

The large lexicon has been automatically created by taking the words
from various sources (Estonian WordNet, Estonian multi-word units database,
Estonian Constraint Grammar verb lexicon) and applying EstNLTK v1.4.1
(https://estnltk.github.io/estnltk) to generate their wordforms.
(Note that for verbs an older stand-alone version of ESTMORF/Vabamorf was used.)

The lexicon files are generated with `make-dict.sh`, which references several
tools and resources available at https://github.com/GF-Estonian/.
For various statistics on the generated lexicon, see `dict-stat.txt`.

Installation
------------

To integrate this lexicon with the Estonian RG, copy the 2 gf-files into `estonian`.
Also, in case the translation lexicon references `DictEst` then update the translation
lexicon:

    cat translator/DictionaryEst.gf | replace-with-d.py -l estonian/DictEstAbs.gf > translator/new_DictionaryEst.gf
    cp translator/new_DictionaryEst.gf translator/DictionaryEst.gf

Release notes
-------------

### 2017.09

- nouns, adjectives and adverbs updated based on the EstNLTK v1.4.1 (contains WordNet and Vabamorf)
- noun/adjective lemma must now match the 1st form. This avoids incorrect entries like: `inimesed_N = mkN "inimene" ...`
- we generally represent compounds using "mkN mkN" (as before), unless the last part of the compound has
  multiple forms in genitive (e.g. "palk", "nukk", "maks", "kott").
  Because the EstNLTK synthesizer can handle compounding and is smart about such words, we let it generate forms
  from the compound, e.g. `kuupalk->kuupalga`, `kantpalk->kantpalgi`.
