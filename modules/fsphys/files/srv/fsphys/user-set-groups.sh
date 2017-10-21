#!/bin/sh
# Fügt bestimmte Nutzer zu einigen Nutzergruppen hinzu.
# Parameter #1: Der Nutzer, dessen Gruppen aktualisiert werden sollen

user="$1"

# Nicht ausführen, wenn:
# - $user nicht gesetzt ist
# - der Nutzer ein System-Account (UID < 1000) ist
if [ -z "$user" ] || [ $(id -u "$user") -lt 1000 ]; then
	exit 0
fi

# Füge Mitglieder der Gruppe „p0fsphys“ zu den Gruppen „cdrom“ und „plugdev“
# hinzu
if id -Gn "$user" | grep '\bp0fsphys\b'; then
	usermod -aG cdrom,plugdev "$user"
fi

