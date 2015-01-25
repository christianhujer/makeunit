PREFIX:=/usr/local/
INCDIR=$(PREFIX)include/

## Installs makeunit on your system.
.PHONY: install
install:
	install -d $(INCDIR)makeunit/
	install -t $(INCDIR)makeunit/ include/makeunit/*

## Removes makeunit from your system.
.PHONY: uninstall
uninstall:
	$(RM) -r $(INCDIR)makeunit/

## Runs the self-test.
.PHONY: test
test:
	$(MAKE) -C selftest/

## Removes all auto-generated files.
.PHONY: clean
clean:
	$(MAKE) -C selftest/ clean
