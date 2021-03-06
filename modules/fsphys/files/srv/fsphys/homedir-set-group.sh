#!/bin/sh
# Ändert die Gruppe des Home-Verzeichnisses einmalig auf p0fsphys.
# Ist die Datei ~/.config/fsphys/firstlogin vorhanden, wird keine Änderung
# durchgeführt.
# Parameter #1: Der Nutzer, dessen Home-Verzeichnis verändert werden soll

user="$1"
fsphys_config_path="/home/$user/.config/fsphys"
firstlogin_path="$fsphys_config_path/firstlogin"

# Nicht ausführen, wenn:
# - $user nicht gesetzt ist
# - der Nutzer ein System-Account (UID < 1000) ist
# - die Datei $fsphys_config_path bereits existiert
if [ -z "$user" ] || \
	[ $(id -u "$user") -lt 1000 ] || \
	[ -f "$firstlogin_path" ]
then
	exit 0
fi

# Gruppe des Home-Verzeichnisses ändern (nicht rekursiv!)
chgrp p0fsphys "/home/$user/"
# Gruppe der Unterordner rekursiv ändern – aber nicht die Ordner
# Fachschaftsplatte und IVV4_I-Laufwerk (Netzlaufwerke)
find "/home/$user/" -mindepth 1 -maxdepth 1 \
	! \( -path "/home/$user/Fachschaftsplatte" -o \
		-path "/home/$user/IVV4_I-Laufwerk" \
	\) \
	-exec chgrp -hR p0fsphys {} +
# s-Bit setzen, damit alle im Home-Verzeichnis erstellten Dateien die
# Gruppe „erben“
chmod g+s "/home/$user/"
# „Cookie-Datei“ erzeugen
mkdir -p "$fsphys_config_path/"
touch "$firstlogin_path"
# Gibt es einen besseren Weg, hier den Besitzer anzupassen?
chown $user:p0fsphys "/home/$user/.config/"
chown -R $user:p0fsphys "$fsphys_config_path/"

