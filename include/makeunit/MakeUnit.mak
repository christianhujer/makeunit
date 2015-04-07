ifeq (undefined,$(origin MAKEUNIT/MAKEUNIT.MAK))
MAKEUNIT/MAKEUNIT.MAK:=$(lastword $(MAKEFILE_LIST))

export SHELL:=bash

.PHONY: test
## Runs all tests.
test: ;

.PHONY: clean
clean: cleanMakeUnit

.PHONY: cleanMakeUnit
## Cleans the files generated by the tests.
cleanMakeUnit:
	$(RM) -r actual

actual:
	mkdir -p $@

.PRECIOUS: actual/%.stdout actual/%.stderr
actual/%.stdout actual/%.stderr: ./createproject.sh | actual
	echo $(gitroot) >>filesToRemove.txt
	$(NEG) ./$^ $(OPTIONS) >actual/$*.stdout 2>actual/$*.stderr

include makeunit/Assert.mak
endif
