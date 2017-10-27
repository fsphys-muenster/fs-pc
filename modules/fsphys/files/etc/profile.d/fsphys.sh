#!/bin/sh

# Nicht für System-Nutzer (UID < 1000) ausführen
if [ $(id -u) -lt 1000 ]; then
	exit 0
fi

# Sicherstellen, dass die Verzeichnisse für Firefox und Thunderbird auf dem
# Netzlaufwerk existieren, damit die symbolischen Links im Home-Verzeichnis
# nicht ins Leere zeigen.
mkdir -p ~/IVV4_I-Laufwerk/AppData/Mozilla/Firefox/
mkdir -p ~/IVV4_I-Laufwerk/AppData/Thunderbird/

# Leere sqlite-Dateien aus Firefox-Profilen entfernen.
# Diese rufen die Fehlermeldung „Das Lesezeichen- und Chronik-System wird
# nicht funktionieren…“ hervor.
# S. auch
# https://support.mozilla.org/de/kb/Das-Lesezeichen-und-Chronik-System-wird-nicht-funktionieren
find ~/.mozilla/firefox/Profiles/ \
	-maxdepth 2 \
	-name '*.sqlite*' -empty \
	-exec rm {} +

