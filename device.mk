#
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This file includes all definitions that apply to ALL tuna devices, and
# are also specific to tuna devices
#
# Everything in this directory will become public


DEVICE_FOLDER := device/samsung/tuna

$(call inherit-product, hardware/ti/omap4xxx/omap4.mk)

DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

TARGET_BOARD_OUT_DIR := tuna

# We have 3 different variants of this device:
# - maguro (GSM)
# - toro (CDMA/LTE, VZW)
# - toroplus (CDMA/LTE, SPR)
# We need to set some stuff up based on what device we're working with.
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/variants/tunasetup.sh:system/vendor/bin/tunasetup.sh \
	$(DEVICE_FOLDER)/variants/maguro.prop:system/vendor/maguro/build.prop \
	$(DEVICE_FOLDER)/variants/toro.prop:system/vendor/toro/build.prop \
	$(DEVICE_FOLDER)/variants/toroplus.prop:system/vendor/toroplus/build.prop

#toro apns
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/etc/apns-conf.xml:system/vendor/toro/etc/apns-conf.xml

# Setup custom omap4xxx defines
# BOARD_USE_CUSTOM_LIBION := true

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_PACKAGES += \
	camera.omap4 \
	lights.tuna \
	charger_res_images \
	nfc.tuna \
	libpn544_fw \
	power.tuna

# RIL
PRODUCT_PACKAGES += \
	libsecril-client \
	libsecril-compat \
	libsecril-shim

PRODUCT_PACKAGES += \
	sensors.tuna

# Audio
PRODUCT_PACKAGES += \
	audio.primary.tuna \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

ifeq ($(TARGET_TUNA_AUDIO_HDMI),true)
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/audio/policy/audio_policy.hdmi.conf:system/etc/audio_policy.conf
else
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/audio/policy/audio_policy.default.conf:system/etc/audio_policy.conf
endif

PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/audio/audio_effects.conf:system/etc/audio_effects.conf \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
	$(DEVICE_FOLDER)/etc/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Default to the Speex resampler, if it exists.
# - This allows for playback of just about any sample rate as the Speex resampler doesn't
#   have the in <= out*2 restriction, and is of a higher quality than the default resampler.
# PRODUCT_PROPERTY_OVERRIDES := \
#	af.resampler.quality=8

PRODUCT_PACKAGES += \
	tuna_hdcp_keys

#PRODUCT_PACKAGES += \
#	keystore.tuna

PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/init.tuna.rc:root/init.tuna.rc \
	$(DEVICE_FOLDER)/rootdir/init.tuna.usb.rc:root/init.tuna.usb.rc \
	$(DEVICE_FOLDER)/rootdir/fstab.tuna:root/fstab.tuna \
	$(DEVICE_FOLDER)/rootdir/ueventd.tuna.rc:root/ueventd.tuna.rc \
	$(DEVICE_FOLDER)/etc/media_profiles.xml:system/etc/media_profiles.xml \
	$(DEVICE_FOLDER)/etc/media_codecs.xml:system/etc/media_codecs.xml \
	$(DEVICE_FOLDER)/recovery/twrp.fstab:recovery/root/etc/twrp.fstab
#	$(DEVICE_FOLDER)/rootdir/init.recovery.tuna.rc:root/init.recovery.tuna.rc


# Wifi
ifneq ($(TARGET_PREBUILT_WIFI_MODULE),)
PRODUCT_COPY_FILES += \
	$(TARGET_PREBUILT_WIFI_MODULE):system/lib/modules/bcmdhd.ko
endif
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/etc/wifi/bcmdhd.maguro.cal:system/etc/wifi/bcmdhd.maguro.cal \
	$(DEVICE_FOLDER)/etc/wifi/bcmdhd.toro.cal:system/etc/wifi/bcmdhd.toro.cal \
	$(DEVICE_FOLDER)/etc/wifi/bcmdhd.toroplus.cal:system/etc/wifi/bcmdhd.toroplus.cal

# NFC
PRODUCT_PACKAGES += \
	Nfc \
	Tag

# Live Wallpapers
PRODUCT_PACKAGES += \
	LiveWallpapers \
	LiveWallpapersPicker \
	VisualizationWallpapers \
	librs_jni

# Key maps
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/keymaps/tuna-gpio-keypad.kl:system/usr/keylayout/tuna-gpio-keypad.kl \
	$(DEVICE_FOLDER)/keymaps/tuna-gpio-keypad.kcm:system/usr/keychars/tuna-gpio-keypad.kcm \
	$(DEVICE_FOLDER)/keymaps/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
	$(DEVICE_FOLDER)/keymaps/sec_jack.kcm:system/usr/keychars/sec_jack.kcm \
	$(DEVICE_FOLDER)/keymaps/sii9234_rcp.kl:system/usr/keylayout/sii9234_rcp.kl \
	$(DEVICE_FOLDER)/keymaps/sii9234_rcp.kcm:system/usr/keychars/sii9234_rcp.kcm

# Input device calibration files
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/Melfas_MMSxxx_Touchscreen.idc:system/usr/idc/Melfas_MMSxxx_Touchscreen.idc

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# Portrait dock image'
# Not used anymore as far as I can tell
#PRODUCT_COPY_FILES += \
#	$(DEVICE_FOLDER)/dock.png:system/vendor/res/images/dock/dock.png

# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
PRODUCT_COPY_FILES += $(call add-to-product-copy-files-if-exists,\
packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt)

# file that declares the MIFARE NFC constant
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml

# NFC EXTRAS add-on API
PRODUCT_PACKAGES += \
	com.android.nfc_extras
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
	NFCEE_ACCESS_PATH := $(DEVICE_FOLDER)/nfc/nfcee_access.xml
else
	NFCEE_ACCESS_PATH := $(DEVICE_FOLDER)/nfc/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
	$(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

PRODUCT_CHARACTERISTICS := nosdcard

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	librs_jni \
	com.android.future.usb.accessory

# TI OMAP4
PRODUCT_PACKAGES += \
	pvrsrvinit 

# Expand Notification Shade in landscape mode to fill display width.
PRODUCT_PROPERTY_OVERRIDES += \
        ro.notif_expand_landscape=1

# Configure maximum number of recents cards to keep. Valid range: 0-98.
PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.max_recents=10

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck \
	setup_fs

# F2FS filesystem
PRODUCT_PACKAGES += \
	mkfs.f2fs \
	fsck.f2fs \
	fibmap.f2fs \
	f2fstat

PRODUCT_PACKAGES += \
	libwpa_client \
	hostapd \
	dhcpcd.conf \
	wpa_supplicant \
	wpa_supplicant.conf

PRODUCT_COPY_FILES += \
	device/samsung/tuna/prebuilt/xbin/displayblank:system/xbin/displayblank 

# DCC
ifneq ($(TARGET_PREBUILT_CAMERA_CALIB),true)
PRODUCT_PACKAGES += \
	dumpdcc
endif

# cdma is for toro and toroplus, gsm is for maguro.
# the ones not applicable to the device will be removed on first boot-up.
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

$(call inherit-product, vendor/ti/omap4/omap4-vendor.mk)
$(call inherit-product, vendor/samsung/tuna/device-vendor.mk)

BOARD_WLAN_DEVICE_REV := bcm4330_b2
WIFI_BAND             := 802_11_ABG
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
