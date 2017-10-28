#!/bin/sh
# Durchläuft einen Synchronisationszyklus zwischen der Fachschaftsplatte und
# der sciebo-Projektbox der Fachschaft.
# Voraussetzungen zur erfolgreichen Ausführung:
# - Das Home-Verzeichnis des ausführenden Nutzers muss eine Datei
#   „fsphys_credentials“ enthalten, die die Zugangsdaten eines Nutzers
#   beinhaltet, der auf die Fachschaftsplatte zugreifen darf.
#   (vgl. „man mount.cifs“)
# - Das Home-Verzeichnis des ausführenden Nutzers muss eine Datei „.netrc“
#   enthalten, die die Zugangsdaten eines Nutzers beinhaltet, der auf die
#   sciebo-Projektbox der Fachschaft zugreifen darf.
#   (vgl. „man owncloudcmd“, „man netrc“)
# - Der ausführende Nutzer muss berechtigt sein, „mount“ und „umount“ per sudo
#   als root auszuführen.

mount_opts=',vers=3.0,nobrl,nodev,nosuid'
ts_format='[%Y-%m-%d %H:%M:%S]'
owncloudcmd_log="$HOME/owncloudcmd.log"

mkdir -p ~/p0fsphys/
sudo mount -t cifs //nwznas02.nwz.wwu.de/p0fsphys ~/p0fsphys/ \
	-o "credentials=$HOME/fsphys_credentials,uid=$(id -u)$mount_opts"
# owncloudcmd nur ausführen, falls mount erfolgreich war
if [ $? -eq 0]; then
	owncloudcmd -n -h --non-interactive \
		~/p0fsphys/G01/ \
		https://uni-muenster.sciebo.de/remote.php/webdav/Fachschaft/Fachschaftsplatte \
		2>&1 | ts "$ts_format" >> "$owncloudcmd_log"
	echo 'owncloudcmd done' | ts "$ts_format" >> "$owncloudcmd_log"
fi
sudo umount -l ~/p0fsphys/
logrotate -l ~/logrotate.log -s ~/logrotate_status ~/logrotate.conf

