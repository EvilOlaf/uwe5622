driver_uwe5622() {

	# Wireless drivers for Unisoc uwe5622 wireless

	if linux-version compare "${version}" ge 5.15 && linux-version compare "${version}" lt 7.2 && [[ "$LINUXFAMILY" == sun* || "$LINUXFAMILY" == rockchip64 || "$LINUXFAMILY" == rk35xx ]]; then

		display_alert "Adding" "Drivers for Unisoc uwe5622 found on some Allwinner and Rockchip boards" "info"

		if linux-version compare "${version}" ge 6.3; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-allwinner-v6.3.patch" "applying"
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-allwinner-bugfix-v6.3.patch" "applying"
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-allwinner-v6.3-compilation-fix.patch" "applying"
		else
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-allwinner.patch" "applying"
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-allwinner-bugfix.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.4; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.4-post.patch" "applying"
		fi

		process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-warnings.patch" "applying"

		# Add to section Makefile
		echo "obj-\$(CONFIG_SPARD_WLAN_SUPPORT) += uwe5622/" >> "$kerneldir/drivers/net/wireless/Makefile"

		# Don't add this to legacy (<5.0) kernels.
		if linux-version compare "${version}" ge 5.0 && linux-version compare "${version}" lt 6.1; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-park-link-pre-v6.1.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.1; then
			if linux-version compare "${version}" ge 6.2 && linux-version compare "${version}" lt 6.3; then # only for 6.2.y
				process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-park-link-v6.2-only.patch" "applying"
			else # assume 6.1.y y > 30
				process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-park-link-v6.1-post.patch" "applying"
			fi
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.1.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.6; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.6-fix-tty-sdio.patch" "applying"
		fi

		if [[ "$LINUXFAMILY" == sun* ]]; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-fix-setting-mac-address-for-netdev.patch" "applying"
		fi

		# Apply patches that adjust the driver only for rockchip platforms
		if [[ "$LINUXFAMILY" == rockchip* || "$LINUXFAMILY" == "rk35xx" ]]; then
			if linux-version compare "${version}" le 6.1; then
				process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-adjust-for-rockchip-pre-6.1.patch"
			else
				process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-adjust-for-rockchip-post-6.1.patch"
			fi
		fi

		process_patch_file "${SRC}/patch/misc/wireless-uwe5622/wireless-uwe5622-Fix-compilation-with-6.7-kernel.patch" "applying"
		process_patch_file "${SRC}/patch/misc/wireless-uwe5622/wireless-uwe5622-reduce-system-load.patch" "applying"

		if linux-version compare "${version}" ge 6.9; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.9.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.11; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.11.patch" "applying"
		fi

		# Fix "spanning-writes" warning in dmesg, applicable when kernel is compiled with FORTIFY_SOURCE
		if linux-version compare "${version}" ge 6.12; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-fix-spanning-writes.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.15; then
			if [[ "$LINUXFAMILY" == sun* ]]; then
				process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-fix-timer-api-changes-for-6.15-only-sunxi.patch" "applying"
			else
				process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.15-timer-api-changes.patch" "applying"
			fi
		fi

		if linux-version compare "${version}" ge 6.16; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.16.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.17; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.17.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.18; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.18.patch" "applying"
		fi

		if linux-version compare "${version}" ge 6.19; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v6.19.patch" "applying"
		fi

		if linux-version compare "${version}" ge 7.1; then
			process_patch_file "${SRC}/patch/misc/wireless-uwe5622/uwe5622-v7.1.patch" "applying"
		fi

		process_patch_file "${SRC}/patch/misc/wireless-uwe5622/wireless-uwe5622-Fix-missing-prototypes.patch" "applying"
	fi
}
