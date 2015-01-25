ifeq (,$(MUNITASSERT.MAK))
MUNITASSERT.MAK=$(lastword $(MAKEFILE_LIST))

## Asserts that % exists and is empty.
assertExistsAndIsEmpty(%): %
	[[ -e $< && ! -s $< ]]

## Asserts that % exists and is not empty.
assertExistsAndIsNonEmpty(%): %
	[[ -e $< && -s $< ]]

## Asserts that % exists and is a directory.
assertExistsAndIsDirectory(%): %
	[[ -e $< && -d $< ]]

endif
