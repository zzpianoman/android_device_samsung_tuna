LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := pvrsrvinit.c
LOCAL_LDFLAGS := -L vendor/samsung/tuna/common/proprietary/vendor/lib
LOCAL_LDLIBS := -lsrv_init_SGX540_120 -lsrv_um_SGX540_120
LOCAL_MODULE_PATH := $(TARGET_OUT)/bin/
LOCAL_MODULE := pvrsrvinit
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)
