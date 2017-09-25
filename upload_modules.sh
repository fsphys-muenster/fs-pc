#!/bin/sh
# Kopiert den Inhalt des Ordners „modules“ nach nwzpuppet.nwz.wwu.de.
# Die Dateien, die aus rechtlichen oder anderen Gründen (keytab, Schriftarten)
# nicht in diesem Repository enthalten sind, werden aus dem Ordner „private“
# auf nwzpuppet.nwz.wwu.de ($path/fsphys/files/private/) an den richtigen Ort
# kopiert.

path_default='/etc/puppetlabs/code/environments/p2fsphys/modules/'
echo 'Bitte den gewünschten Zielpfad (…/modules/) angeben'
echo "(Voreinstellung: $path_default)"
read path
if [ -z "$path" ]; then
	path="$path_default"
fi
echo 'Nutzername auf nwzpuppet.nwz.wwu.de angeben:'
read -r user
echo 'Passwort für diesen Nutzer angeben:'
stty -echo
read -r SSHPASS
export SSHPASS
stty echo

sshpass -e rsync -avz modules/ "$user@nwzpuppet.nwz.wwu.de:$path"
sshpass -e ssh "$user@nwzpuppet.nwz.wwu.de" \
"cd '$path/fsphys/files/';"\
"cp    private/keytab   srv/fsphys/;"\
"cp    private/*.*      srv/fsphys/;"\
"cp -r private/ff-meta/ usr/local/share/fonts/;"\
"chgrp -R p2fsphys '$path';"\
"chmod -R u=rwx,g=rwx,o-rwx '$path'"

SSHPASS=''

