#!/bin/sh
# Installiert alle verwendeten Puppet-Module von Puppet Forge auf
# nwzpuppet.nwz.wwu.de

path_default='/etc/puppetlabs/code/environments/p2fsphys_test/modules/'
echo 'Bitte den gewünschten Zielpfad angeben'
echo "(Voreinstellung: $path_default)"
read path
if [ -z "$path" ]; then
	path="$path_default"
fi
for module in \
	cpick/gdebi \
	stbenjam/hash_resources \
	puppetlabs/motd \
	kb/pam_mount \
	walkamongus/realmd \
	ghoneycutt/ssh \
; do
	puppet module install --target-dir "$path" "$module"
done

