#!/bin/sh
# Überprüfe alle YAML-Dateien mit yamllint
# https://github.com/adrienverge/yamllint

find .. -iname '*.yaml' -exec yamllint -c yamllint.conf {} +
