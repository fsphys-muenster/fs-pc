#!/bin/sh
# Ändert die Gruppe des Home-Verzeichnisses einmalig auf p0fsphys.
# Ist die Datei ~/.config/fsphys/firstlogin vorhanden, wird keine Änderung
# durchgeführt.

user=$PAM_USER
fsphys_config_path="/home/$user/.config/fsphys"
firstlogin_path="$fsphys_config_path/firstlogin"

# Nicht für System-Accounts ausführen (UID < 1000)
if [ \( $(id -u $user) -ge 1000 \) -a \( ! -f "$firstlogin_path" \) ]; then
	# Gruppe rekursiv ändern – aber nicht für die Ordner
	# Fachschaftsplatte und IVV4_I-Laufwerk
	find "/home/$user/" -maxdepth 1 \
		! \( -name Fachschaftsplatte -o -name IVV4_I-Laufwerk \) \
		-exec chgrp -R p0fsphys {} +
	# s-Bit setzen, damit alle im Home-Verzeichnis erstellten Dateien die
	# Gruppe „erben“
	chmod g+s "/home/$user/"
	# „Cookie-Datei“ erzeugen
	mkdir -p "$fsphys_config_path/"
	touch "$firstlogin_path"
	# Gibt es einen besseren Weg, hier den Besitzer anzupassen?
	chown $user:p0fsphys "/home/$user/.config/"
	chown -R $user:p0fsphys "$fsphys_config_path/"
fi

