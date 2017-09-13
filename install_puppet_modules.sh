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
	kb/pam_mount \
	geoffwilliams/r_profile \
	walkamongus/realmd \
	ghoneycutt/ssh \
; do
	puppet module install --target-dir "$path" "$module"
done

