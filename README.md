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
