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

DEVICE_PACKAGE_OVERLAYS := $(DEVICE_FOLDER)/overlay

TARGET_BOARD_OUT_DIR := tuna

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# HALs
PRODUCT_PACKAGES := \
	lights.tuna \
	nfc.tuna \
	power.tuna \
	audio.primary.tuna \
	memtrack.omap4

# Sensors
PRODUCT_PACKAGES += \
	sensors.tuna \
	libinvensense_mpl

# Support charger mode
PRODUCT_PACKAGES += \
	charger \
	charger_res_images

# Audio
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

# RIL
PRODUCT_PACKAGES += \
	libsecril-client

PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf \
	$(DEVICE_FOLDER)/prebuilt/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf \
	frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
	frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

#AOSP bootanimation
PRODUCT_BOOTANIMATION := $(DEVICE_FOLDER)/prebuilt/media/bootanimation.zip:system/media/bootanimation.zip
	

#PRODUCT_PROPERTY_OVERRIDES := \
	#af.resampler.quality=8

PRODUCT_PACKAGES += \
	tuna_hdcp_keys

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
	media.aac_51_output_enabled=true

#PRODUCT_PACKAGES += \
#	keystore.tuna

# Init files
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/init.tuna.rc:root/init.tuna.rc \
	$(DEVICE_FOLDER)/rootdir/init.tuna.usb.rc:root/init.tuna.usb.rc \
	$(DEVICE_FOLDER)/rootdir/ueventd.tuna.rc:root/ueventd.tuna.rc

# Fstab
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/rootdir/fstab.tuna:root/fstab.tuna

# GPS
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/etc/gps.conf:system/etc/gps.conf

# Media profiles
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
	$(DEVICE_FOLDER)/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml

# Wifi
ifneq ($(TARGET_PREBUILT_WIFI_MODULE),)
PRODUCT_COPY_FILES += \
	$(TARGET_PREBUILT_WIFI_MODULE):system/lib/modules/bcmdhd.ko
endif
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/etc/wifi/bcmdhd.cal:system/etc/wifi/bcmdhd.cal

PRODUCT_PROPERTY_OVERRIDES := \
	wifi.interface=wlan0

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp

# Torch
PRODUCT_PACKAGES += \
	Torch

# Legacy Camera
PRODUCT_PACKAGES += \
	LegacyCamera

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
	$(DEVICE_FOLDER)/prebuilt/usr/keylayout/tuna-gpio-keypad.kl:system/usr/keylayout/tuna-gpio-keypad.kl \
	$(DEVICE_FOLDER)/prebuilt/usr/keychars/tuna-gpio-keypad.kcm:system/usr/keychars/tuna-gpio-keypad.kcm \
	$(DEVICE_FOLDER)/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
	$(DEVICE_FOLDER)/prebuilt/usr/keychars/sec_jack.kcm:system/usr/keychars/sec_jack.kcm \
	$(DEVICE_FOLDER)/prebuilt/usr/keylayout/sii9234_rcp.kl:system/usr/keylayout/sii9234_rcp.kl \
	$(DEVICE_FOLDER)/prebuilt/usr/keychars/sii9234_rcp.kcm:system/usr/keychars/sii9234_rcp.kcm

# Input device calibration files
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/usr/idc/Melfas_MMSxxx_Touchscreen.idc:system/usr/idc/Melfas_MMSxxx_Touchscreen.idc

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
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
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml

# Melfas touchscreen firmware
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/vendor/firmware/mms144_ts_rev31.fw:system/vendor/firmware/mms144_ts_rev31.fw \
	$(DEVICE_FOLDER)/prebuilt/vendor/firmware/mms144_ts_rev32.fw:system/vendor/firmware/mms144_ts_rev32.fw

# Portrait dock image
PRODUCT_COPY_FILES += \
	$(DEVICE_FOLDER)/prebuilt/vendor/res/images/dock/dock.png:system/vendor/res/images/dock/dock.png

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
	NFCEE_ACCESS_PATH := $(DEVICE_FOLDER)/prebuilt/etc/nfcee_access.xml
else
	NFCEE_ACCESS_PATH := $(DEVICE_FOLDER)/prebuilt/etc/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
	$(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=131072 \
	ro.sf.lcd_density=320 \
	ro.hwui.disable_scissor_opt=true \
	debug.hwui.render_dirty_regions=false

# GPU producer to CPU consumer not supported
PRODUCT_PROPERTY_OVERRIDES += \
	ro.bq.gpu_to_cpu_unsupported=1

PRODUCT_CHARACTERISTICS := nosdcard

PRODUCT_TAGS += \
	dalvik.gc.type-precise

PRODUCT_PACKAGES += \
	com.android.future.usb.accessory

# Newer camera API isn't supported.
PRODUCT_PROPERTY_OVERRIDES += \
	camera2.portability.force_api=1

# Since we only have 1 SIM, make sure this is obvious
PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.sim.count=1

# Enable/Disable AppOps control for platform-signed apps (Disabled by default)
PRODUCT_PROPERTY_OVERRIDES += \
 	ro.appops.show_platform=0

# Configure maximum number of recents cards to keep. Valid range: 0-98.
PRODUCT_PROPERTY_OVERRIDES += \
	ro.config.max_recents=10

# Expand Notification Shade in landscape mode to fill display width.
PRODUCT_PROPERTY_OVERRIDES += \
        ro.notif_expand_landscape=1

# Hide low_ram flag from Google Camera
PRODUCT_PROPERTY_OVERRIDES += \
        ro.config.lowram_hide_apps=com.google.android.GoogleCamera

# Memory management tweaks.
PRODUCT_PROPERTY_OVERRIDES += \
        ro.config.low_ram=true \
        persist.sys.force_highendgfx=true \
        ro.config.max_starting_bg=4

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

# TI OMAP4
PRODUCT_PACKAGES += \
	pvrsrvinit 

# Enable KSM by default
#PRODUCT_PROPERTY_OVERRIDES += \
	#ro.ksm.default=1

PRODUCT_PACKAGES += \
	libwpa_client \
	hostapd \
	dhcpcd.conf \
	wpa_supplicant \
	wpa_supplicant.conf

PRODUCT_COPY_FILES += \
	device/samsung/tuna/prebuilt/etc/init.d/96screendim:system/etc/init.d/96screendim \
	device/samsung/tuna/prebuilt/xbin/displayblank:system/xbin/displayblank 

# DCC
PRODUCT_PACKAGES += \
    dumpdcc

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

$(call inherit-product-if-exists, vendor/nxp/pn544/nxp-pn544-fw-vendor.mk)
$(call inherit-product, hardware/ti/omap4xxx/omap4.mk)
#$(call inherit-product-if-exists, vendor/ti/proprietary/omap4/ti-omap4-vendor.mk)
$(call inherit-product-if-exists, vendor/samsung/tuna/tuna-vendor.mk)

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
