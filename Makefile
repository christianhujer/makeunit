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

.PHONY: dist
## Creates the distribution archives.
dist: dist/makeunit.tar.gz dist/makeunit.tar.bz2 dist/makeunit.zip dist/makeunit.deb

dist/makeunit.tar.gz: dist/makeunit.tar
dist/makeunit.tar.bz2: dist/makeunit.tar

%.gz: %
	<$< gzip -9 >$@

%.bz2: %
	<$< bzip2 -9 >$@

dist/makeunit.tar dist/makeunit.zip:
	mkdir -p dist
	git archive -o $@ --prefix makehelp/ HEAD .

.PHONY: clean
## Removes all auto-generated files.
clean:
	$(RM) -r dist control data/ data.tar.gz control.tar.gz debian-binary
	$(MAKE) -C selftest/ clean

control:
	echo "Package: makeunit\nVersion: 0.1.0\nSection: user/hidden\nPriority: optional\nArchitecture: all\nInstalled-Size: `du -cks include/ | tail -n 1 | cut -f 1`\nMaintainer: Christian Hujer<cher@riedquat.de>\nDescription: amkeunit - Unit Testing in Makefiles." >$@

control.tar.gz: control
	tar czf $@ $^

data.tar.gz: data/
	tar czf $@ --transform 's,^\./,/,' -C $< .

data/:
	$(MAKE) PREFIX=data/usr/

debian-binary:
	echo 2.0 >$@

dist/makeunit.deb: debian-binary control.tar.gz data.tar.gz
	ar -Drc $@ $^

.PHONY: test
## Runs the self-test.
test:
	$(MAKE) -C selftest/

-include makehelp/Help.mak
