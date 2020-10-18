THEOS_PACKAGE_DIR_NAME = debs
CURRENT_DIR = $(shell echo $$PWD)
TARGET := simulator:clang:latest:13.0
ARCHS = x86_64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = debugLog

debugLog_FILES = ./tweak/Tweak.x
debugLog_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

ifneq (,$(filter x86_64 i386,$(ARCHS)))
simulator:
	@chmod 700 $(CURRENT_DIR)/.resources/makeSim/makeSim.sh;\
	export TWEAK_NAME=$(TWEAK_NAME);\
	$(CURRENT_DIR)/.resources/makeSim/makeSim.sh;
endif


