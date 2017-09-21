#!/bin/sh
# Ändert die Gruppe des Home-Verzeichnisses einmalig auf p0fsphys.
# Ist die Datei ~/.config/fsphys/firstlogin vorhanden, wird keine Änderung
# durchgeführt.

user=$PAM_USER

# do not run for system users (UID < 1000)
if [ $(id -u) -lt 1000 ]; then
	exit
fi
fsphys_config_path="/home/$user/.config/fsphys"
firstlogin_path="$fsphys_config_path/firstlogin"
if [ ! -f "$firstlogin_path" ]; then
	chgrp p0fsphys "/home/$user/"
	sudo -u $PAM_USER mkdir -p "$fsphys_config_path/"
	sudo -u $PAM_USER touch "$firstlogin_path"
fi

