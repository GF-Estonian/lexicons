all: help

help:
	@echo "Some commands for testing the lexicon:"
	@echo
	@echo " load_dict: load DictEst (to use 'cc')"
	@echo "            e.g."
	@echo "            > cc -table 'küberspionaaž_N'"
	@echo "            > cc -table valmis_A"
	@echo "            > cc -table abivalmis_A"
	@echo "            > cc -table abi_andma_V"
	@echo "            > cc -table kohe_Adv"
	@echo
	@echo " dict_stat: update dict_stat.txt"
	@echo
	@echo "     clean: remove gfo-files"

load_dict:
	gf +RTS -K50M -RTS --retain DictEst.gf

dict_stat:
	../../tools/lexicon/dict-stat.sh Est ./ > dict-stat.txt

clean:
	find . -name "*.gfo" | xargs rm -f
