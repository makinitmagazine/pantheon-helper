#!/bin/bash
# Using rsync to download files from Pantheon DEV environment.
# USAGE:
# Use the script directly from the /sites/default/ folder, files will sync into files/ folder.
## Change ENV to dev test live
export ENV=dev
## Specify Pantheon SITE
export SITE=13cd6f18-64ba-40c2-8d33-7c5ec8e06af5
## rsync
rsync -rlvz --size-only --ipv4 --progress -e 'ssh -p 2222' $ENV.$SITE@appserver.$ENV.$SITE.drush.in:code/sites/default/files/ ~/files
