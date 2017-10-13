#!/bin/sh
# Installiert alle verwendeten Puppet-Module von Puppet Forge auf
# nwzpuppet.nwz.wwu.de

path_default='/etc/puppetlabs/code/environments/p2fsphys/modules/'
echo 'Bitte den gewünschten Zielpfad (…/modules/) angeben'
echo "(Voreinstellung: $path_default)"
read -r path
if [ -z "$path" ]; then
	path="$path_default"
fi
for module in \
	 puppetlabs-apt \
	  leoarnold-cups \
	 camptocamp-gnome \
	   stbenjam-hash_resources \
	 puppetlabs-motd \
	         kb-pam_mount \
	walkamongus-realmd \
	 ghoneycutt-ssh \
	     puppet-unattended_upgrades \
; do
	puppet module install --target-dir "$path" "$module"
done
# Berechtigungen setzen
chgrp -R p2fsphys "$path"
chmod -R u=rwx,g=rwx,o=rx "$path"

