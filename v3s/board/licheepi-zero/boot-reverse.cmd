setenv bootargs console=tty0 earlyprintk root=/dev/mmcblk0p2 rootwait

mmc dev 0
fatload mmc 0 $kernel_addr_r zImage
fatload mmc 0 $fdt_addr_r sun8i-v3s-licheepi-zero-reverse.dtb

bootz $kernel_addr_r - $fdt_addr_r

