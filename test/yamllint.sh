#!/bin/sh
# Überprüft alle YAML-Dateien mit yamllint
# https://github.com/adrienverge/yamllint

script_path=$(dirname "$0")
find -iname '*.yaml' -exec yamllint -c "$script_path/yamllint.conf" {} +

