include makeunit/MakeUnit.mak

define succeeds=
.PHONY test: given_$(1)_when_$(2)_thenSucceeds
given_$(1)_when_$(2)_thenSucceeds:
	$(MAKE) '$(2)($(1))'
	$(MAKE) -- '$(3)($(1))'
endef

define fails=
.PHONY test: given_$(1)_when_$(2)_thenFails
given_$(1)_when_$(2)_thenFails:
	! $(MAKE) '$(2)($(1))'
	! $(MAKE) -- '$(3)($(1))'
endef

$(eval $(call fails,nonExisting,assertExists,-e))
$(eval $(call succeeds,existingEmptyFile,assertExists,-e))
$(eval $(call succeeds,existingNonEmptyFile,assertExists,-e))
$(eval $(call succeeds,existingDirectory,assertExists,-e))

$(eval $(call succeeds,nonExisting,assertIsEmpty,!-s))
$(eval $(call succeeds,existingEmptyFile,assertIsEmpty,!-s))
$(eval $(call fails,existingNonEmptyFile,assertIsEmpty,!-s))
$(eval $(call fails,existingDirectory,assertIsEmpty,!-s))

$(eval $(call fails,nonExisting,assertExistsAndIsEmpty,-e&!-s))
$(eval $(call succeeds,existingEmptyFile,assertExistsAndIsEmpty,-e&!-s))
$(eval $(call fails,existingNonEmptyFile,assertExistsAndIsEmpty,-e&!-s))
$(eval $(call fails,existingDirectory,assertExistsAndIsEmpty,-e&!-s))

$(eval $(call fails,nonExisting,assertExistsAndIsNonEmpty,-s))
$(eval $(call fails,existingEmptyFile,assertExistsAndIsNonEmpty,-s))
$(eval $(call succeeds,existingNonEmptyFile,assertExistsAndIsNonEmpty,-s))
$(eval $(call succeeds,existingDirectory,assertExistsAndIsNonEmpty,-s))

$(eval $(call fails,nonExisting,assertIsDirectory,-d))
$(eval $(call fails,existingEmptyFile,assertIsDirectory,-d))
$(eval $(call fails,existingNonEmptyFile,assertIsDirectory,-d))
$(eval $(call succeeds,existingDirectory,assertIsDirectory,-d))


nonExisting: ;

existingEmptyFile:
	touch $@

existingNonEmptyFile:
	echo foo >$@

existingDirectory:
	mkdir -p $@

.PHONY: clean
clean: cleanAssertTest

.PHONY: cleanAssertTest
cleanAssertTest:
	$(RM) existingEmptyFile existingNonEmptyFile
