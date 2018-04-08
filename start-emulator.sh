#!/bin/bash
#set -x  # echo on


android_sdk_location="/opt/google/Android/Sdk"
avd_name="Nexus_5X_API_27_x86"

# Android Emulator usage: emulator [options] [-qemu args]
#   options:
#     -accel <mode>                   Configure emulation acceleration
#     -avd <name>                     use a specific android virtual device
#     -engine <engine>                Select engine. auto|classic|qemu2
#     -gpu <mode>                     set hardware OpenGLES emulation mode
#     -list-avds                      list available AVDs
#     -ranchu                         Use new emulator backend instead of the classic one
#     -use-system-libs                Use system libstdc++ instead of bundled one
#
#      -qemu args...                  pass arguments to qemu

$android_sdk_location/emulator/emulator -list-avds
# Nexus_5X_API_27_x86

$android_sdk_location/emulator/emulator \
    -accel on \
    -avd "$avd_name" \
    -engine qemu2 \
    -gpu on \
    -ranchu \
    -use-system-libs \
    -qemu \
        -m 2047 \
        -enable-kvm
