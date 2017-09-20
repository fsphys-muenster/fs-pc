#!/bin/sh

# Gruppe des Home-Verzeichnisses einmalig auf p0fsphys ändern.
#fsphys_config_path=~/.config/fsphys/
#firstlogin_path="$fsphys_config_path"firstlogin
#if [ ! -f "$firstlogin_path" ]; then
#	chgrp p0fsphys ~
#	mkdir -p "$fsphys_config_path"
#	touch "$firstlogin_path"
#fi

# Sicherstellen, dass die Verzeichnisse für Firefox und Thunderbird auf dem
# Netzlaufwerk existieren, damit die symbolischen Links im Home-Verzeichnis
# nicht ins Leere zeigen.
mkdir -p ~/IVV4_I-Laufwerk/AppData/Mozilla/Firefox/
mkdir -p ~/IVV4_I-Laufwerk/AppData/Thunderbird/

