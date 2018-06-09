USE_CAMERA_STUB := true

#
# Device
#
DEVICE_DIR := device/aqr/i4pro
VENDOR_DIR := vendor/aqr/i4pro
KERNEL_DIR := kernel/aqr/i4pro

# Additional includes
TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_DIR)/include

# inherit from the proprietary version
-include $(VENDOR_DIR)/BoardConfigVendor.mk

#
# Architecture
#
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_NEON := true

#
# Board
#
TARGET_BOARD_PLATFORM := mt6580
TARGET_BOARD_PLATFORM_GPU := mali-400mp

BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 998244352
BOARD_USERDATAIMAGE_PARTITION_SIZE := 14302052352
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_HAS_NO_REAL_SDCARD := true
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false


#
# Kernel
#
BUILD_KERNEL_FROM_SOURCE := false
ifeq ($(BUILD_KERNEL_FROM_SOURCE),true)
    # build kernel from sources
    TARGET_KERNEL_SOURCE := $(KERNEL_DIR)
    TARGET_KERNEL_CONFIG := mt6580_defconfig
    TARGET_KMODULES := true         # is it needed ?
else
    # use prebuilt kernel
    TARGET_PREBUILT_KERNEL := $(DEVICE_DIR)/kernel
endif

BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := bootopt=64S3,32S1,32S1 androidboot.selinux=permissive

#
# Boot
#
#BOARD_MKBOOTIMG_ARGS := --base 0x80000000 --pagesize 2048 --kernel_offset 0x00008000 --ramdisk_offset 0x04000000 --tags_offset 0x0e000000 #--second_offset = 0x0f00000
BOARD_MKBOOTIMG_ARGS := --base 0x80000000 --pagesize 2048 --kernel_offset 0x00008000 --ramdisk_offset 0x04000000 --second_offset 0x0f00000 --tags_offset 0x0e000000 --board i4Pro
# --second_offset 0x80f00000


#
# MTK
#
BOARD_HAS_MTK_HARDWARE := true
MTK_HARDWARE := true

BOARD_CONNECTIVITY_VENDOR := MediaTek
BOARD_CONNECTIVITY_MODULE := conn_soc
BOARD_USES_MTK_AUDIO := true


#
# Graphics
#
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := $(DEVICE_DIR)/configs/egl.cfg
BOARD_EGL_WORKAROUND_BUG_10194508 := true

TARGET_USES_ION := true
TARGET_USES_OVERLAY := true

# Surfaceflinger optimization for VD surfaces
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Tests - TODO ?
#TARGET_USES_C2D_COMPOSITION := true
#TARGET_DISPLAY_USE_RETIRE_FENCE := true
#MAX_EGL_CACHE_KEY_SIZE := 12*1024
#MAX_EGL_CACHE_SIZE := 1024*1024

#
# WIFI
#
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P

BOARD_CONNECTIVITY_VENDOR := MediaTek
BOARD_CONNECTIVITY_MODULE := conn_soc
BOARD_USES_MTK_AUDIO := true

#
# BT
#
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MTK := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_DIR)/include

#
# Extra flags
#
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
COMMON_GLOBAL_CFLAGS += -DMTK_HARDWARE
COMMON_GLOBAL_CFLAGS += -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL
COMMON_GLOBAL_CFLAGS += -DREFRESH_RATE=60
COMMON_GLOBAL_CFLAGS += -DDISABLE_HW_ID_MATCH_CHECK
COMMON_GLOBAL_CFLAGS += -DDISABLE_ASHMEM_TRACKING

TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -DMTK_HARDWARE


# libxlog
TARGET_LDPRELOAD += libxlog.so

#
# Debug
#
TARGET_USES_LOGD := true

# Tests...
WITH_DEXPREOPT := false 
DISABLE_DEXPREOPT := true 

# Hack for building without kernel sources
$(shell mkdir -p $(OUT)/obj/KERNEL_OBJ/usr)

