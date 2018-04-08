#!/bin/bash
#set -x  # echo on




sudo apt-get install cpu-checker

egrep -c '(vmx|svm)' /proc/cpuinfo
# 8

kvm-ok
# INFO: /dev/kvm exists
# KVM acceleration can be used




# Install the KVM
sudo apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils
sudo apt-get install virtinst

# Add your local user account to the group kvm and libvirtd.
sudo adduser `id -un` libvirtd
sudo adduser `id -un` kvm
# In Ubuntu 16.10, the group has been renamed to libvirt instead of libvirtd.
# After the installation, you need to relogin so that your user account becomes an effective member of kvm and libvirtd user groups.
# The members of this group can run virtual machines.

# Verify installation in Terminal:
sudo virsh -c qemu:///system list
#  Id    Name                           State
# ----------------------------------------------------




# You can use the emulator -accel-check command-line option to check whether you have KVM installed.
/opt/google/Android/Sdk/tools/emulator -accel-check
# accel:
# 0
# KVM (version 12) is installed and usable.
# accel
