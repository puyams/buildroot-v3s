# buildroot-v3s #

An external layer for buildroot to get Allwinner V3s based systems (like the
LicheePi Zero) up and running.

Based upon the information of the
[buildroot user manual](https://buildroot.org/downloads/manual/manual.html)
about keeping customizations outside of buildroot.

A script `setup.sh` is added to simplify the usage of the additional layer
by also including the download, unpacking and configuration of a vanilla
buildroot.

# Hardware #

I bought my hardware here:
* [without dock](https://www.banggood.com/Lichee-Pi-Zero-1_2GHz-Cortex-A7-512Mbit-DDR-Core-Board-Development-Board-Mini-PC-p-1351124.html)
* [with dock](https://www.banggood.com/LicheePi-Zero-1GHz-Cortex-A7-512Mbit-DDR-Development-Board-Mini-PC-p-1337966.html)
* [800x480 LCD](https://www.banggood.com/Lichee-Pi-5-inch-LCD-Display-RTP-800480-Resolution-With-4-wire-Resistive-Touch-Screen-p-1340806.html)

# Configurations for squonk42 layer #

This is a configuration for a Lichee Pi Zero board adapeted from
https://github.com/Squonk42/buildroot-licheepi-zero .

## Versions ##

| Component | Version     | Comment                                          |
| --------- | ----------- | ------------------------------------------------ |
| Buildroot | 2018.05     |                                                  |
| Linux     | zero-4.14.y | fork: https://github.com/Lichee-Pi/linux         |
| U-Boot    | v3s-current | fork: https://github.com/Lichee-Pi/u-boot        |

## Supported Hardware Status ##

Hardware of Lichee Pi Zero as supported by Kernel branch "zero-4.14.y":

| Hardware Feature | Status                                                  |
| -----------------| ------------------------------------------------------- |
| USB gadget       | working: serial (ttyGS0) + ethernet (usb0)              |
| ethernet         | working                                                 |
| MMC0             | working, boot media                                     |
| MMC1             | working with uSD card, SDIO not tested                  |
| MMC2             | not tested (same pins as SPI0)                          |
| UART0            | not tested, ttyS0 shows up in dmesg                     |
| UART1            | seems not to be configured                              |
| UART2            | seems not to be configured                              |
| SPI0             | not tested                                              |
| I2C0             | not tested                                              |
| I2C1             | not tested                                              |
| 4 buttons        | working, show effect in /dev/input/event0               |
| audio playback   | working                                                 |
| audio recording  | not working (probably due to wrong mixer configuration) |
| LCD (800x480)    | not working (most probably not enabled, wrong dtb)      |
| camera           | not tested (no hardware)                                |

# Configurations for v3s layer #

A try to get a configuration for a Lichee Pi Zero board adapeted just using
mainline components. The configs are split up into different variants,
including the dock and a 800x480 LCD.

| Defconfig                               | Status                           |
| --------------------------------------- | -------------------------------- |
| licheepi_zero_defconfig                 | untested                         |
| licheepi_zero_dock_defconfig            | working as squonk42 layer        |
| licheepi_zero_lcd800x480_defconfig      | untested                         |
| licheepi_zero_dock_lcd800x480_defconfig | not booting due to broken dtb    |

## Versions ##

| Component | Version     | Comment                                          |
| --------- | ----------- | ------------------------------------------------ |
| Buildroot | 2019.02.1   |                                                  |
| Linux     | zero-4.14.y | fork: https://github.com/Lichee-Pi/linux         |
| U-Boot    | v3s-current | fork: https://github.com/Lichee-Pi/u-boot        |

Later on a port to mainline kernel and U-Boot is planned.

## Supported Hardware Status ##

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
