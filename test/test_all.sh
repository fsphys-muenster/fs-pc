#!/bin/sh
# Führt alle Tests (Puppet, YAML…) durch.

./puppet-parser-validate.sh
./yamllint.sh

