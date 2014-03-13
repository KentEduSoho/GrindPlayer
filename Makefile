FLEX_SDK = /Users/kentwei15/flashsdk
MXMLC = $(FLEX_SDK)/bin/mxmlc
COMPC = $(FLEX_SDK)/bin/compc
BUILD_DIR = build
GRIND_PLAYER=$(BUILD_DIR)/GrindPlayer.swf
GRIND_FRAMEWORK=$(BUILD_DIR)/libs/GrindFramework.swc
#ADVERTISEMENT_PLUGIN=$(BUILD_DIR)/libs/AdvertisementPlugin.swc
#SUBTITLES_PLUGIN=$(BUILD_DIR)/libs/SubtitlesPlugin.swc

DEBUG ?= false
LOGGING ?= false

TARGET_PLAYER ?= 10.2

SRC = src/GrindPlayer.mxml

all: $(GRIND_PLAYER)


clean:
	rm -rf build


$(BUILD_DIR): $(BUILD_DIR)/libs
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/libs:
	mkdir -p $(BUILD_DIR)/libs
	cp libs/* $(BUILD_DIR)/libs/

$(GRIND_PLAYER): $(BUILD_DIR) $(GRIND_FRAMEWORK)  $(SRC)
	$(MXMLC) -o $(GRIND_PLAYER) \
	-debug=$(DEBUG) \
	-actionscript-file-encoding=utf-8 \
	-locale=zh_CN \
	-optimize=true \
	-swf-version=11 \
	-target-player=$(TARGET_PLAYER) \
	-default-size=640,360 \
	-default-background-color=0 \
	-sp src locale/{locale} \
	-l "$(FLEX_SDK)/frameworks/libs" "$(FLEX_SDK)/frameworks/locale/{locale}" \
	-l libs "$(BUILD_DIR)/libs" \
	-define CONFIG::HLS false \
	-define CONFIG::DEV false \
	src/GrindPlayer.mxml \


GrindFramework:
	git clone git://github.com/kutu/GrindFramework --depth 1


$(GRIND_FRAMEWORK): GrindFramework
	$(COMPC) -o $(GRIND_FRAMEWORK) \
	-debug=$(DEBUG) \
	-swf-version=11 \
	-target-player=$(TARGET_PLAYER) \
	-optimize=true \
	-sp "GrindFramework/src" \
	-is "GrindFramework/src" \
	-external-library-path+="$(FLEX_SDK)/frameworks/libs",libs \
	-define CONFIG::LOGGING $(LOGGING) \
	-define CONFIG::FLASH_10_1 true


