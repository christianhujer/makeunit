include makeunit/MakeUnit.mak

.PHONY test: givenNonExistingFile_whenAssertingExistenceAndEmptiness_thenFails
givenNonExistingFile_whenAssertingExistenceAndEmptiness_thenFails:
	! $(MAKE) 'assertExistsAndIsEmpty(nonExistingFile)'

.PHONY test: givenExistingEmptyFile_whenAssertingExistenceAndEmptiness_thenSucceeds
givenExistingEmptyFile_whenAssertingExistenceAndEmptiness_thenSucceeds:
	$(MAKE) 'assertExistsAndIsEmpty(existingEmptyFile)'

.PHONY test: givenExistingNonEmptyFile_whenAssertingExistenceAndEmptiness_thenFails
givenExistingNonEmptyFile_whenAssertingExistenceAndEmptiness_thenFails:
	! $(MAKE) 'assertExistsAndIsEmpty(existingNonEmptyFile)'

.PHONY test: givenNonExistingFile_whenAssertingExistenceAndNonEmptiness_thenFails
givenNonExistingFile_whenAssertingExistenceAndNonEmptiness_thenFails:
	! $(MAKE) 'assertExistsAndIsNonEmpty(nonExistingFile)'

.PHONY test: givenExistingEmptyFile_whenAssertingExistenceAndNonEmptiness_thenFails
givenExistingEmptyFile_whenAssertingExistenceAndNonEmptiness_thenFails:
	! $(MAKE) 'assertExistsAndIsNonEmpty(existingEmptyFile)'

.PHONY test: givenExistingNonEmptyFile_whenAssertingExistenceAndNonEmptiness_thenSucceeds
givenExistingNonEmptyFile_whenAssertingExistenceAndNonEmptiness_thenSucceeds:
	$(MAKE) 'assertExistsAndIsNonEmpty(existingNonEmptyFile)'

nonExistingFile: ;

existingEmptyFile:
	touch $@

existingNonEmptyFile:
	echo foo >$@

.PHONY: clean
clean: cleanAssertTest

.PHONY: cleanAssertTest
cleanAssertTest:
	$(RM) existingEmptyFile existingNonEmptyFile
