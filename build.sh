#!/bin/bash

rm -r site
mkdocs build -f mkdocs.en.yml
mkdocs build -f mkdocs.ko.yml
mkdocs build -f mkdocs.uk.yml
