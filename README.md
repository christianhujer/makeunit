# makeunit

makeunit is a GNU make based unit test framework / DSL for acceptance testing command line programs.

## Directory structure

* `include/` contains the makeunit Makefiles.
* `selftest/` contains the makeunit selftest.

## Installation
To install makeunit, run `make install`.
This will install makeunit in the include path.
The default location is a `makehelp` subdirectory in `$(INCDIR)` which is `/usr/local/include/`.
You can change the location of `$(INCDIR)` by setting `INCDIR` or `PREFIX` on the command line.
For example, to install makeunit in `/usr/include/makeunit/` instead, run `make PREFIX=/usr/`.

## Usage
To use MakeUnit, include `makeunit/MakeUnit.mak` in your Makefile, like this:

~~~~
include makeunit/MakeUnit.mak
~~~~

### Tests
Tests can be written like this:

~~~~
include makeunit/MakeUnit.mak

.PHONY test: givenExistingFileNonEmptyFile_whenGreppingForDot_thenSucceeds:
givenExistingFileNonEmptyFile_whenGreppingForDot_thenSucceeds: data/existingNonEmptyFile
	grep . $^

.PHONY test: givenExistingEmptyFile_whenGreepingForDot_thenFails
givenExistingEmptyFile_whenGreepingForDot_thenFails: data/existingEmptyFile
	! grep . $^

data/existingNonEmptyFile: | data/
	echo foo >$@

data/existingEmptyFile: | data/
	touch $@

data/:
	mkdir -p $@

.PHONY: clean
clean: cleanData

.PHONY: cleanData
cleanData:
	$(RM) -r data/
~~~~

### Assertions

MakeUnit has a few assertions.
Currently, the following assertions exist: `assertExistsAndIsEmpty(ARG)`, `assertExistsAndIsNonEmpty(ARG)`, `assertExistsAndIsDirectory(ARG)`.

These assertions can be used as preconditions.

To see which assertions are there, consult `include/makehelp/Assert.mak`.

### Postcondition Pitfall and Solution Pattern
`make` does not support postconditions other than checking the command exit status.
In order to realize postconditions with preconditions, the insertion of additional rules is required.

Therefore, tests should split their arrangement, action and assertion accordingly into separate rules.

Here's an example.
It tests that when calling `./test.sh`, `stderr` and `stdout` are empty and `testFile` is created as empty file.

~~~~
NEG?=

actual/:
	mkdir -p $@

.PRECIOUS: actual/%.stdout actual/%.stderr
actual/%.stdout actual/%.stderr: ./test.sh | actual/
	$(NEG) ./%^ $(OPTIONS) >actual/$*.stdout 2>actual/$*.stderr

test .PHONY: createsTestFile
createsTestFile: OPTIONS:=testFile
createsTestFile: assertExistsAndIsEmpty(actual/createsTestFile.stderr)
createsTestFile: assertExistsAndIsEmpty(actual/createsTestFile.stdout)
createsTestFile: assertExistsAndIsEmpty(testFile)
# You could add additional postconditions as recipe (shell lines) to createsTestFile
~~~~
