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

.PHONY: test
## Runs the self-test.
test:
	$(MAKE) -C selftest/

.PHONY: clean
## Removes all auto-generated files.
clean:
	$(MAKE) -C selftest/ clean

-include makehelp/Help.mak
