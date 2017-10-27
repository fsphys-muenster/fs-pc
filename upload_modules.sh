#!/bin/sh
# Kopiert den Inhalt des Ordners „modules“ nach nwzpuppet.nwz.wwu.de.
# Die Dateien, die aus rechtlichen oder anderen Gründen (keytab, Schriftarten)
# nicht in diesem Repository enthalten sind, werden aus dem Ordner „private“
# auf nwzpuppet.nwz.wwu.de ($path/fsphys/files/private/) an den richtigen Ort
# kopiert.

path_default='/etc/puppetlabs/code/environments/p2fsphys'
echo 'Bitte den gewünschten Zielpfad zur Foreman-Umgebung angeben'
echo "(Voreinstellung: $path_default/)"
read -r path
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

sshpass -e rsync -avz --delete \
	modules/* "$user@nwzpuppet.nwz.wwu.de:$path/modules/"
sshpass -e ssh "$user@nwzpuppet.nwz.wwu.de" \
"cd '$path/';"\
"cp    private/keytab   modules/fsphys/files/srv/fsphys/;"\
"cp    private/*.*      modules/fsphys/files/srv/fsphys/;"\
"cp -r private/ff-meta/ modules/fsphys/files/usr/local/share/fonts/;"\
"chgrp -R p2fsphys '$path/modules/'           2>/dev/null;"\
"chmod -R u=rwx,g=rwxs,o-rwx '$path/modules/' 2>/dev/null"

SSHPASS=''

