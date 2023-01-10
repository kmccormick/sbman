# Secure Boot MANager

This script helps manage Secure Boot with (your own) self-signed keys.
The keys are stored on your disk so you *must use full-disk encryption*.

Tested on Ubuntu. Kernels are installed as monolithic signed EFI binaries
and boot from systemd-boot (no Grub).

Supports multiple EFI System Partitions so you can still boot if a device
fails.

## Prerequisites

* efi-readvar
* efi-updatevar
* sbsign
* kmodsign
* cert-to-efi-sig-list
* sign-efi-sig-list
* objcopy

(apt install -y efitools binutils)

Configure EFI System Partition like this in /etc/fstab:
```
PARTLABEL=esp0  /boot/efi  vfat  noauto,x-systemd.automount,x-systemd.idle-timeout=60
```

If you have additional ESPs on mirror disks, also setup x-systemd.automounts for
them at e.g. /boot/efi1.

## Initial Setup

1. Boot system to system UEFI firmware setup
2. Configure Secure Boot for custom keys
3. Save and reboot
4. Install via `make`
5. Run setup: `sbman setup` which will:
    * Generate new Secure Boot keys to /etc/secureboot
    * Install Secure Boot keys to EFI variables for install next boot
    * Sign and install systemd-boot on the EFI system partition
    * Generate and sign a monolithic kernel+initramfs+cmdline EFI binary
    * Coordiante future automatic signing as kernel or initramfs changes
6. Reboot to system UEFI firmware setup
7. Enable Secure Boot
