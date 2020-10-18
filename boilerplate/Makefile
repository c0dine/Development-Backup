THEOS_PACKAGE_DIR_NAME = debs
CURRENT_DIR = $(shell echo $$PWD)
TARGET := simulator:clang:latest:7.0
ARCHS = x86_64 i386
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = boilerPlate

boilerPlate_FILES = ./tweak/main.xm ./tweak/memSpoof.xm ./tweak/welcome.xm
boilerPlate_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

ifneq (,$(filter x86_64 i386,$(ARCHS)))
simulator:
	@chmod 700 $(CURRENT_DIR)/.resources/makeSim/makeSim.sh; export TWEAK_NAME=$(TWEAK_NAME); $(CURRENT_DIR)/.resources/makeSim/makeSim.sh;
endif