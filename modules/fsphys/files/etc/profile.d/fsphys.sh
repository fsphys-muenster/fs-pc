#!/bin/sh

# Sicherstellen, dass die Verzeichnisse für Firefox und Thunderbird auf dem
# Netzlaufwerk existieren, damit die symbolischen Links im Home-Verzeichnis
# nicht ins Leere zeigen.
mkdir -p ~/IVV4_I-Laufwerk/AppData/Mozilla/Firefox/
mkdir -p ~/IVV4_I-Laufwerk/AppData/Thunderbird/
# Platzhalter {$USER} in GTK-Lesezeichen ersetzen
sed -ni s/'{$USER}'/$(whoami)/g ~/.config/gtk-3.0/bookmarks 2>/dev/null

