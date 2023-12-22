install: /usr/local/sbin/sbman /etc/initramfs/post-update.d/sbman_update_initramfs /etc/kernel/postrm.d/sbman_kernel_postrm /etc/systemd/system/update-esps-generator.service

/usr/local/sbin/sbman: sbman
	install sbman -o root -g root -m 0755 $@

/etc/initramfs/post-update.d:
	mkdir -m 0755 $@

/etc/initramfs/post-update.d/sbman_update_initramfs: /etc/initramfs/post-update.d
	ln -sf ../../../usr/local/sbin/sbman $@

/etc/kernel/postrm.d/sbman_kernel_postrm:
	ln -sf ../../../usr/local/sbin/sbman $@

/etc/systemd/system/update-esps-generator.service: update-esps-generator.service
	install update-esps-generator.service -o root -g root -m 0644 $@
	systemctl daemon-reload
	systemctl enable update-esps-generator.service

uninstall:
	systemctl disable update-esps-generator.service
	rm -f \
		/usr/local/sbin/sbman \
		/etc/initramfs/post-update.d/sbman_update_initramfs \
		/etc/kernel/postrm.d/sbman_kernel_postrm \
		/etc/systemd/system/update-esps-generator.service
	systemctl daemon-reload
