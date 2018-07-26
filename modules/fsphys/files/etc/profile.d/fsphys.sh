#!/bin/sh

# Nicht für System-Nutzer (UID < 1000) ausführen
if [ $(id -u) -ge 1000 ]; then
	# Sicherstellen, dass die Verzeichnisse für Firefox und Thunderbird auf dem
	# Netzlaufwerk existieren, damit die symbolischen Links im Home-Verzeichnis
	# nicht ins Leere zeigen.
	mkdir -p ~/IVV4_I-Laufwerk/AppData/Mozilla/Firefox/
	mkdir -p ~/IVV4_I-Laufwerk/AppData/Thunderbird/
	# Platzhalter {$USER} in GTK-Lesezeichen ersetzen
	sed -i s/'{$USER}'/$(whoami)/g ~/.config/gtk-3.0/bookmarks 2>/dev/null

	# Leere sqlite-Dateien aus Firefox-Profilen entfernen.
	# Diese rufen die Fehlermeldung „Das Lesezeichen- und Chronik-System wird
	# nicht funktionieren…“ hervor.
	# S. auch
	# https://support.mozilla.org/de/kb/Das-Lesezeichen-und-Chronik-System-wird-nicht-funktionieren
	if [ -d ~/.mozilla/firefox/Profiles/ ]; then
		find ~/.mozilla/firefox/Profiles/ \
			-maxdepth 2 \
			-name '*.sqlite*' -empty \
			-exec rm {} +
	fi
fi

