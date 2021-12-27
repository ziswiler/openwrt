define Device/mikrotik_nand
	DEVICE_VENDOR := MikroTik
	KERNEL_NAME := vmlinux
	KERNEL_INITRAMFS := kernel-bin | append-dtb-elf
	KERNEL := kernel-bin | append-dtb-elf | package-kernel-ubifs | \
		ubinize-kernel
	IMAGES := nand-sysupgrade.bin
	IMAGE/nand-sysupgrade.bin := sysupgrade-tar | append-metadata
endef

define Device/mikrotik_rb3011
	$(call Device/mikrotik_nand)
	DEVICE_MODEL := RouterBOARD RB3011UiAS
	SOC := qcom-ipq8064
	BLOCKSIZE := 128k
	PAGESIZE := 2048
	KERNEL_UBIFS_OPTS = -m $$(PAGESIZE) -e 124KiB -c $$(PAGESIZE) -x none
	DEVICE_PACKAGES := kmod-gpio-beeper
endef
TARGET_DEVICES += mikrotik_rb3011
