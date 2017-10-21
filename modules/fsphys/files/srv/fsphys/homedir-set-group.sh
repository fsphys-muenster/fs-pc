#!/bin/sh
# Ändert die Gruppe des Home-Verzeichnisses einmalig auf p0fsphys.
# Ist die Datei ~/.config/fsphys/firstlogin vorhanden, wird keine Änderung
# durchgeführt.

user=$PAM_USER
fsphys_config_path="/home/$user/.config/fsphys"
firstlogin_path="$fsphys_config_path/firstlogin"

# Nicht ausführen, wenn:
# - $PAM_USER nicht gesetzt ist
# - der Nutzer ein System-Account (UID < 1000) ist
# - die Datei $fsphys_config_path bereits existiert
if [ -z "$PAM_USER" ] || \
	[ $(id -u $user) -lt 1000 ] || \
	[ -f "$firstlogin_path" ]
then
	exit 0
fi

# Gruppe rekursiv ändern – aber nicht die Ordner
# Fachschaftsplatte und IVV4_I-Laufwerk (Netzlaufwerke)
find "/home/$user/" -maxdepth 1 \
	! \( -o -name Fachschaftsplatte -o -name IVV4_I-Laufwerk \) \
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

