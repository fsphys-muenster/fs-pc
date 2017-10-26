#!/bin/sh

# Sicherstellen, dass die Verzeichnisse für Firefox und Thunderbird auf dem
# Netzlaufwerk existieren, damit die symbolischen Links im Home-Verzeichnis
# nicht ins Leere zeigen.
mkdir -p ~/IVV4_I-Laufwerk/AppData/Mozilla/Firefox/
mkdir -p ~/IVV4_I-Laufwerk/AppData/Thunderbird/

# Entfernen korrupter sqlite-Datenbank aus Firefox-Profil
find ~/IVV4_I-Laufwerk/AppData/Mozilla/Firefox/Profiles/ -maxdepth 2 -name 'favicons.sqlite*' -empty -exec rm {} +
