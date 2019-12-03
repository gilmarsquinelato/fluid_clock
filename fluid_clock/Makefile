MESSAGES_DART_PATH = lib/messages.dart
I18N_PATH = lib/i18n

FILES := $(shell find $(I18N_PATH) -name '*.arb' | xargs)

PUB_RUN = flutter packages pub run

extract-to-arb:
	$(PUB_RUN) intl_translation:extract_to_arb --output-dir=$(I18N_PATH) $(MESSAGES_DART_PATH)


generate-from-arb:
	rm -rf $(L10N_PATH)/*.dart
	$(PUB_RUN) intl_translation:generate_from_arb \
	--output-dir=$(I18N_PATH) \
	--no-use-deferred-loading \
	$(MESSAGES_DART_PATH) \
	$(FILES)
