install:
	install sbman -o root -g root -m 0755 /usr/local/sbin/sbman
	install sbman -o root -g root -m 0755 -D /etc/initramfs/post-update.d/sbman_update_initramfs
	install sbman -o root -g root -m 0755 /etc/kernel/postrm.d/sbman_kernel_postrm
	install update-esps-generator.service -o root -g root -m 0644 /etc/systemd/system/update-esps-generator.service
	systemctl daemon-reload
	systemctl enable update-esps-generator.service

uninstall:
	rm -f \
		/usr/local/sbin/sbman \
		/etc/initramfs/post-update.d/sbman_update_initramfs \
		/etc/kernel/postrm.d/sbman_kernel_postrm
