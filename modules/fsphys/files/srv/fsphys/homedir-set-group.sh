#!/bin/sh
# Ändert die Gruppe des Home-Verzeichnisses einmalig auf p0fsphys.

for homedir in $(ls /home/); do
	fsphys_config_path="/home/$homedir/.config/fsphys"
	firstlogin_path="$fsphys_config_path/firstlogin"
	if [ ! -f "$firstlogin_path" ]; then
		chgrp p0fsphys "/home/$homedir/"
		mkdir -p "$fsphys_config_path/"
		touch "$firstlogin_path"
	fi
done

