include makeunit/MakeUnit.mak
include makeunit/MakeUnit.mak

.PHONY test: givenNonExistingFile_whenAssertingExistenceAndEmptiness_thenFails
givenNonExistingFile_whenAssertingExistenceAndEmptiness_thenFails:
	! $(MAKE) 'assertExistsAndIsEmpty(nonExistingFile)'

.PHONY test: givenExistingEmptyFile_whenAssertingExistenceAndEmptiness_thenSucceeds
givenExistingEmptyFile_whenAssertingExistenceAndEmptiness_thenSucceeds:
	$(MAKE) 'assertExistsAndIsEmpty(existingEmptyFile)'

nonExistingFile: ;

existingEmptyFile:
	touch $@

existingNonEmptyFile:
	echo foo >$@

.PHONY: clean
clean:
	$(RM) existingEmptyFile existingNonEmptyFile
