#!/bin/sh
# Starts a new terminal window and runs the program in $1 within this window.
# The working directory is set to the directory containing $1.

TEXTDOMAIN=run-terminal-emulator
TEXTDOMAINDIR=/srv/fsphys/run-terminal-emulator/
msg=$(gettext -s 'Script execution completed. Press ENTER to close.')
gnome-terminal --working-directory="$(dirname "$1")" -- \
	sh -c "'$1' ; echo ; echo $msg ; read _"

