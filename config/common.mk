PRODUCT_BRAND ?= du

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    persist.sys.root_access=1

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/du/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/du/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/du/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/du/prebuilt/bin/99-backup.sh:system/addon.d/99-backup.sh \
    vendor/du/prebuilt/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
    vendor/du/prebuilt/etc/00banner:system/etc/init.d/00banner \
    vendor/du/prebuilt/bin/sysinit:system/bin/sysinit

# Init script file with DU extras
PRODUCT_COPY_FILES += \
    vendor/du/prebuilt/etc/init.local.rc:root/init.du.rc

# Boot Animation
PRODUCT_COPY_FILES += \
    vendor/du/prebuilt/media/bootanimation.zip:system/media/bootanimation.zip

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Additional packages
-include vendor/du/config/packages.mk

# Versioning
-include vendor/du/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/du/overlay/common

# SU Support
PRODUCT_COPY_FILES += \
    vendor/du/prebuilt/bin/su:system/xbin/daemonsu \
    vendor/du/prebuilt/bin/su:system/xbin/su \
    vendor/du/prebuilt/etc/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon \
    vendor/du/prebuilt/apk/Superuser.apk:system/app/SuperSU/SuperSU.apk

# HFM Files
PRODUCT_COPY_FILES += \
    vendor/du/prebuilt/etc/hosts.alt:system/etc/hosts.alt \
    vendor/du/prebuilt/etc/hosts.og:system/etc/hosts.og

# Versioning System
ANDROID_VERSION = 5.0.0
DU_VERSION = v9.0

ifndef DU_BUILD_TYPE
    DU_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
endif

DU_VERSION := $(TARGET_PRODUCT)_$(ANDROID_VERSION)_$(shell date -u +%Y%m%d-%H%M).$(DU_VERSION)-$(DU_BUILD_TYPE)
DU_MOD_VERSION := $(DU_BUILD_TYPE)-v9.0

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.du.version=$(DU_VERSION) \
    ro.mod.version=$(DU_MOD_VERSION) \
