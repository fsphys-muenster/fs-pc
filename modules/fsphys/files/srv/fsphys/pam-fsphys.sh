#!/bin/sh
# Dieses Skript wird bei der Anmeldung eines Nutzers via PAM (common-session,
# common-session-noninteractive) aufgerufen

user=$PAM_USER

if [ -z "$user" ]; then
	exit 0
fi

/srv/fsphys/homedir-set-group.sh "$user" && \
/srv/fsphys/user-set-groups.sh   "$user"

