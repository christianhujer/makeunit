## Installation prefix.
PREFIX:=/usr/local/

## Installation directory for include files.
INCDIR=$(PREFIX)/include/

.PHONY: install
## Installs makeunit on your system.
install:
	install -d $(INCDIR)/makeunit/
	install -t $(INCDIR)/makeunit/ include/makeunit/*

.PHONY: uninstall
## Removes makeunit from your system.
uninstall:
	$(RM) -r $(INCDIR)/makeunit/

control.Description:=makeunit - Unit Testing in Makefiles.
control.Version:=0.1.0

-include makedist/MakeDist.mak

.PHONY: test
## Runs the self-test.
test:
	$(MAKE) -C selftest/

-include makehelp/Help.mak
