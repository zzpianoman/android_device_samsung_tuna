#!/system/bin/sh

# Only run script if we haven't run it before
if [ -e "/system/vendor/build.prop" ] ;then
    exit
fi

# Delete files for a variant due to it being unused.
delete_maguro_files() {
    rm -r /system/vendor/maguro/
    rm /system/etc/wifi/bcmdhd.maguro.cal
    rm /system/etc/permissions/android.hardware.telephony.gsm.xml
}
delete_torocommon_files() {
    rm -r /system/vendor/toro-common/
    rm /system/etc/permissions/android.hardware.telephony.cdma.xml

    # If we're removing the common toro files, we obviously want ALL toro files removed.
    delete_toro_files
    delete_toroplus_files
}
delete_toro_files() {
    rm -r /system/vendor/toro/
    rm /system/etc/wifi/bcmdhd.toro.cal
}
delete_toroplus_files() {
    rm -r /system/vendor/toroplus/
    rm /system/etc/wifi/bcmdhd.toroplus.cal
}

# Move files for variants to their proper locations.
move_maguro_files() {
    mkdir -p /system/vendor/etc
    mv /system/etc/wifi/bcmdhd.maguro.cal /system/etc/wifi/bcmdhd.cal
    mv /system/vendor/maguro/etc/sirfgps.conf /system/vendor/etc/sirfgps.conf
    mv /system/vendor/maguro/firmware/bcm4330.hcd /system/vendor/firmware/bcm4330.hcd
    mv /system/vendor/maguro/lib/hw/gps.omap4.so /system/vendor/lib/hw/gps.omap4.so
    mv /system/vendor/maguro/lib/libsec-ril.so /system/vendor/lib/libsec-ril.so
}
move_torocommon_files() {
    mkdir -p /system/vendor/etc
    mv /system/vendor/toro-common/etc/sirfgps.conf /system/vendor/etc/sirfgps.conf
    mv /system/vendor/toro-common/firmware/bcm4330.hcd /system/vendor/firmware/bcm4330.hcd
    mv /system/vendor/toro-common/lib/hw/gps.omap4.so /system/vendor/lib/hw/gps.omap4.so
    mv /system/vendor/toro-common/lib/lib_gsd4t.so /system/vendor/lib/lib_gsd4t.so
}
move_toro_files() {
    mv /system/etc/wifi/bcmdhd.toro.cal /system/etc/wifi/bcmdhd.cal
    mv /system/vendor/toro/lib/libims.so /system/vendor/lib/libims.so
    mv /system/vendor/toro/lib/libims_jni.so /system/vendor/lib/libims_jni.so
    mv /system/vendor/toro/lib/libsec-ril_lte.so /system/vendor/lib/libsec-ril_lte.so

#    mkdir -p /system/vendor/app/
#    mv /system/vendor/toro/app/BIP.kpa /system/vendor/app/BIP.apk
#    mv /system/vendor/toro/app/IMSFramework.kpa /system/vendor/app/IMSFramework.apk
#    mv /system/vendor/toro/app/RTN.kpa /system/vendor/app/RTN.apk

    move_torocommon_files
}
move_toroplus_files() {
    mv /system/etc/wifi/bcmdhd.toroplus.cal /system/etc/wifi/bcmdhd.cal
    mv /system/vendor/toroplus/lib/libsec-ril_lte.so /system/vendor/lib/libsec-ril_lte.so

#    mkdir -p /system/vendor/app/
#    mv /system/vendor/toroplus/app/BIP.kpa /system/vendor/app/BIP.apk
#    mv /system/vendor/toroplus/app/HiddenMenu.kpa /system/vendor/app/HiddenMenu.apk
#    mv /system/vendor/toroplus/app/SDM.kpa /system/vendor/app/SDM.apk
#    mv /system/vendor/toroplus/app/SecPhone.kpa /system/vendor/app/SecPhone.apk

    move_torocommon_files
}

# Setup variant-specific properties.
# Tack them on to the end of build.prop, in addition to setting them with setprop right away.
add_props_header() {
    echo "\n# Properties for tuna variant: $1" >> /system/build.prop
}
setup_maguro_props() {
    add_props_header "maguro"

    setprop rild.libpath "/vendor/lib/libsec-ril.so"
    echo "rild.libpath=/vendor/lib/libsec-ril.so" >> /system/build.prop

    setprop telephony.lteOnCdmaDevice 0
    echo "telephony.lteOnCdmaDevice=0" >> /system/build.prop
}
setup_torocommon_props() {
    setprop rild.libpath "/vendor/lib/libsec-ril_lte.so"
    echo "rild.libpath=/vendor/lib/libsec-ril_lte.so" >> /system/build.prop

    setprop telephony.lteOnCdmaDevice 1
    echo "telephony.lteOnCdmaDevice=1" >> /system/build.prop

    setprop ro.ril.ecclist "112,911,#911,*911"
    echo "ro.ril.ecclist=112,911,#911,*911" >> /system/build.prop

    setprop ro.telephony.call_ring.multiple 0
    echo "ro.telephony.call_ring.multiple=0" >> /system/build.prop

    setprop ro.config.vc_call_vol_steps 7
    echo "ro.config.vc_call_vol_steps=7" >> /system/build.prop
}
setup_toro_props() {
    add_props_header "toro"

    setup_torocommon_props

    setprop ro.telephony.default_network 8
    echo "ro.telephony.default_network=8" >> /system/build.prop

    setprop ro.telephony.default_cdma_sub 0
    echo "ro.telephony.default_cdma_sub=0" >> /system/build.prop

    setprop persist.radio.imsregrequired 1
    echo "persist.radio.imsregrequired=1" >> /system/build.prop

    setprop persist.radio.imsallowmtsms 1
    echo "persist.radio.imsallowmtsms=1" >> /system/build.prop


    setprop ro.cdma.home.operator.numeric 311480
    echo "ro.cdma.home.operator.numeric=311480" >> /system/build.prop

    setprop ro.cdma.home.operator.alpha Verizon
    echo "ro.cdma.home.operator.alpha=Verizon" >> /system/build.prop

    setprop ro.cdma.homesystem "64,65,76,77,78,79,80,81,82,83"
    echo "ro.cdma.homesystem=64,65,76,77,78,79,80,81,82,83" >> /system/build.prop

    setprop ro.cdma.data_retry_config "default_randomization=2000,0,0,120000,180000,540000,960000"
    echo "ro.cdma.data_retry_config=default_randomization=2000,0,0,120000,180000,540000,960000" >> /system/build.prop

    setprop ro.gsm.data_retry_config "max_retries=infinite,default_randomization=2000,0,0,80000,125000,485000,905000"
    echo "ro.gsm.data_retry_config=max_retries=infinite,default_randomization=2000,0,0,80000,125000,485000,905000" >> /system/build.prop

    setprop ro.gsm.2nd_data_retry_config "max_retries=infinite,default_randomization=2000,0,0,80000,125000,485000,905000"
    echo "ro.gsm.2nd_data_retry_config=max_retries=infinite,default_randomization=2000,0,0,80000,125000,485000,905000" >> /system/build.prop

    setprop ro.cdma.otaspnumschema "SELC,1,80,99"
    echo "ro.cdma.otaspnumschema=SELC,1,80,99" >> /system/build.prop
}
setup_toroplus_props() {
    add_props_header "toroplus"

    setup_torocommon_props

    setprop ro.telephony.default_network 4
    echo "ro.telephony.default_network=4" >> /system/build.prop

    setprop ro.cdma.home.operator.numeric 310120
    echo "ro.cdma.home.operator.numeric=310120" >> /system/build.prop

    setprop ro.cdma.home.operator.alpha Sprint
    echo "ro.cdma.home.operator.alpha=Sprint" >> /system/build.prop
}



# Remount system rw to allow these changes.
mount -o remount,rw /system

variant=""
cmdline=$(cat /proc/cmdline)

if [ -z "${cmdline##*I9250*}" ] ;then
    variant="maguro"
    move_maguro_files
    delete_torocommon_files
    setup_maguro_props
elif [ -z "${cmdline##*I515*}" ] ;then
    variant="toro"
    move_toro_files
    delete_maguro_files
    delete_toroplus_files
    setup_toro_props
else
    variant="toroplus"
    move_toroplus_files
    delete_maguro_files
    delete_toro_files
    setup_toroplus_props
fi

# Store a file indicating we've run and what variant we set up.
#echo "$variant" > /system/vendor/etc/.variant

# Now that we've finished our job, remount system ro and reboot
mount -o remount,ro /system
reboot
