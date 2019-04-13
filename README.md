# buildroot-v3s #

An external layer for buildroot to get Allwinner V3s based systems (like the
LicheePi Zero) up and running.

Based upon the information of the
[buildroot user manual](https://buildroot.org/downloads/manual/manual.html)
about keeping customizations outside of buildroot.

A script `setup.sh` is added to simplify the usage of the additional layer
by also including the download, unpacking and configuration of a vanilla
buildroot.

# Configurations #

## Squonk42 licheepi_zero ##

This is a configuration for a Lichee Pi Zero board adapeted from
https://github.com/Squonk42/buildroot-licheepi-zero .

### Versions ###

| Component | Version     | Comment                                          |
| --------- | ----------- | ------------------------------------------------ |
| Buildroot | 2018.05     |                                                  |
| Linux     | zero-4.14.y | fork: https://github.com/Lichee-Pi/linux         |
| U-Boot    | v3s-current | fork: https://github.com/Lichee-Pi/u-boot        |

### Supported Hardware Status ###

| Hardware Feature | Status                                                  |
| -----------------| ------------------------------------------------------- |
| USB gadget       | working: serial + ethernet                              |
| ethernet         | working                                                 |
| MMC0             | working, boot media                                     |
| MMC1             | working with uSD card, SDIO not tested                  |
| MMC2             | not tested                                              |
| UART0            | not tested, ttyS0 shows up in dmesg                     |
| UART1            | seems not to be configured                              |
| UART2            | seems not to be configured                              |
| SPI              | not tested                                              |
| I2C0             | not tested                                              |
| I2C1             | not tested                                              |
| audio playback   | working                                                 |
| audio recording  | not working (probably due to wrong mixer configuration) |
| LCD (800x480)    | not working (most probably not enabled)                 |
| camera           | not tested (no hardware)                                |

## v3s licheepi_zero ##
A try to get a configuration for a Lichee Pi Zero board adapeted just using
mainline components

| Component | Version     | Comment                                          |
| --------- | ----------- | ------------------------------------------------ |
| Buildroot | 2019.02.1   |                                                  |
| Linux     | 4.19        | default provided by buildroot                    |
| U-Boot    | 2018.09     | default provided by buildroot                    |

### Supported Hardware Status ###

Since this work in progress at an early stage, so no status yet

| Hardware Feature | Status                                                  |
| -----------------| ------------------------------------------------------- |
| USB gadget       |                                                         |
| ethernet         |                                                         |
| MMC0             |                                                         |
| MMC1             |                                                         |
| MMC2             |                                                         |
| UART0            |                                                         |
| UART1            |                                                         |
| UART2            |                                                         |
| SPI              |                                                         |
| I2C0             |                                                         |
| I2C1             |                                                         |
| audio playback   |                                                         |
| audio recording  |                                                         |
| LCD (800x480)    |                                                         |
| camera           |                                                         |
