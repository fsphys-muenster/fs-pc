#!/bin/sh
# Kopiert die Dateien „fsphys_credentials“ und „.netrc“ aus einem angegebenen
# lokalen Verzeichnis in das Home-Verzeichnis des Nutzers „p0fsphys-sync“ auf
# pcfs42.nwz.wwu.de.

path_default=.
user_default=root

echo 'Bitte den Pfad zum Verzeichnis angeben, das die credentials-Datei für'
echo 'mount.cifs und die netrc-Datei für owncloudcmd enthält:'
echo "(Voreinstellung: $path_default/)"
read -r path
if [ -z "$path" ]; then
	path="$path_default"
fi
echo 'Nutzername auf pcfs42.nwz.wwu.de angeben:'
echo "(Voreinstellung: $user_default)"
read -r user
if [ -z "$user" ]; then
	user="$user_default"
fi

scp "$path/fsphys_credentials" "$path/.netrc" \
	"$user@pcfs42.nwz.wwu.de:/home/p0fsphys-sync/"

