ifeq (undefined,$(origin MUNITASSERT.MAK))
MUNITASSERT.MAK=$(lastword $(MAKEFILE_LIST))

## Asserts that % exists.
assertExists(%): %
	[[ -e $< ]]

## Asserts that % exists.
-e(%): %
	[[ -e $< ]]

## Asserts that % is empty or does not exist.
assertIsEmpty(%): %
	[[ ! -s $< ]]

## Asserts that % is empty or does not exist.
!-s(%): %
	[[ ! -s $< ]]

## Asserts that % exists and is empty.
assertExistsAndIsEmpty(%): %
	[[ -e $< && ! -s $< ]]

## Asserts that % exists and is empty.
-e&!-s(%): %
	[[ -e $< && ! -s $< ]]

## Asserts that % exists and is not empty.
assertExistsAndIsNonEmpty(%): %
	[[ -e $< && -s $< ]]

## Asserts that % exists and is not empty.
-s(%): %
	[[ -s $< ]]

## Asserts that % exists and is a directory.
assertIsDirectory(%): %
	[[ -d $< ]]

## Asserts that % exists and is a directory.
-d(%): %
	[[ -d $< ]]

endif
