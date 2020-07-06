#!/bin/bash

mount_opts=',vers=3.0,nobrl,nodev,nosuid'

mkdir -p /home/p0fsphys-sync/p0fsphys/
until sudo mount -t cifs //nwznas02.nwz.wwu.de/p0fsphys /home/p0fsphys-sync/p0fsphys/ \
	-o "credentials=$HOME/fsphys_credentials,uid=$(id -u)$mount_opts"
# owncloudcmd nur ausführen, falls mount erfolgreich war
do
  sudo umount -l /home/p0fsphys-sync/p0fsphys/
  echo "Mount unsuccessful, trying again..."
done

today="$( date +"%Y-%m-%d" )"

mkdir -p /home/p0fsphys-sync/treediff

# Cleaning up
rm -f "/home/p0fsphys-sync/treediff/filetree-previous.tree" "/home/p0fsphys-sync/treediff/filetree-current.diff" "/home/p0fsphys-sync/treediff/filetree-current.mail"

# New file tree
mv "/home/p0fsphys-sync/treediff/filetree-current.tree" "/home/p0fsphys-sync/treediff/filetree-previous.tree"
#  Try multiple times until convergence, to avoid issues from broken internet connection
tree -ifhD --noreport --timefmt="+%F %T" /home/p0fsphys-sync/p0fsphys/G01 > "/home/p0fsphys-sync/treediff/filetree-current.tree"
tree -ifhD --noreport --timefmt="+%F %T" /home/p0fsphys-sync/p0fsphys/G01 > "/home/p0fsphys-sync/treediff/filetree-current.tree.1"
wc1=`wc -c "/home/p0fsphys-sync/treediff/filetree-current.tree" | cut -d' ' -f1`
wc2=`wc -c "/home/p0fsphys-sync/treediff/filetree-current.tree.1" | cut -d' ' -f1`
while [ $wc1 != $wc2 ]
do
	if [ $wc1 < $wc2 ]
	then
		rm "/home/p0fsphys-sync/treediff/filetree-current.tree"
		mv "/home/p0fsphys-sync/treediff/filetree-current.tree.1" "/home/p0fsphys-sync/treediff/filetree-current.tree"
	fi

	if [ $wc1 > $wc2 ]
	then
		rm "/home/p0fsphys-sync/treediff/filetree-current.tree.1"
	fi

	tree -ifhD --noreport --timefmt="+%F %T" /home/p0fsphys-sync/p0fsphys/G01 > "/home/p0fsphys-sync/treediff/filetree-current.tree.1"

	wc1=`wc -c "/home/p0fsphys-sync/treediff/filetree-current.tree" | cut -d' ' -f1`
	wc2=`wc -c "/home/p0fsphys-sync/treediff/filetree-current.tree.1" | cut -d' ' -f1`
done
rm "/home/p0fsphys-sync/treediff/filetree-current.tree.1"
cp "/home/p0fsphys-sync/treediff/filetree-current.tree" "/home/p0fsphys-sync/treediff/filetree-$today.tree"

# New diff
diff -U 0 "/home/p0fsphys-sync/treediff/filetree-previous.tree" "/home/p0fsphys-sync/treediff/filetree-current.tree" > "/home/p0fsphys-sync/treediff/filetree-current.diff"
cp "/home/p0fsphys-sync/treediff/filetree-current.diff" "/home/p0fsphys-sync/treediff/filetree-$today.diff"

# New mail
cat > "/home/p0fsphys-sync/treediff/filetree-current.mail" <<- EOM
Subject: Änderungen Fachschaftsplatte vom $today


Es folgen Änderungen der vergangenen Woche auf der Fachschaftsplatte.
---
EOM

cat "/home/p0fsphys-sync/treediff/filetree-current.diff" >> "/home/p0fsphys-sync/treediff/filetree-current.mail"
echo "---" >> "/home/p0fsphys-sync/treediff/filetree-current.mail"
/usr/sbin/sendmail fsphys@wwu.de < "/home/p0fsphys-sync/treediff/filetree-current.mail"


sudo umount -l /home/p0fsphys-sync/p0fsphys/

