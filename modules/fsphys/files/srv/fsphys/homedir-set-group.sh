#!/bin/sh
# Ändert die Gruppe des Home-Verzeichnisses einmalig auf p0fsphys.
# Ist die Datei ~/.config/fsphys/firstlogin vorhanden, wird keine Änderung
# durchgeführt.

user=$PAM_USER
fsphys_config_path="/home/$user/.config/fsphys"
firstlogin_path="$fsphys_config_path/firstlogin"

# Nicht für System-Accounts ausführen (UID < 1000)
if [ \( $(id -u $user) -ge 1000 \) -a \( ! -f "$firstlogin_path" \) ]; then
	chgrp p0fsphys "/home/$user/"
	mkdir -p "$fsphys_config_path/"
	touch "$firstlogin_path"
	# Gibt es einen besseren Weg, hier den Besitzer anzupassen?
	# (Problematisch z.B., falls ~/.config/ nicht existiert)
	chown -R $user:p0fsphys "$fsphys_config_path/"
fi

