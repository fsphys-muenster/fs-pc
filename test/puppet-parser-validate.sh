#!/bin/sh
# Überprüft alle Puppet-Dateien (*.pp) mit dem Befehl „puppet parser validate“

find .. -iname '*.pp' -exec puppet parser validate {} +

