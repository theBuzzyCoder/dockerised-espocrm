export WORKDIR=$HOMEDIR/dockerised-espo
mkdir -p $WORKDIR

if [ -d cd $WORKDIR/php7.2-espocrm ]; then
  echo "php directory found";
else
  git clone git://github.com/theBuzzyCoder/dockerised-espo.git $WORKDIR
fi

cd $WORKDIR/php7.2-espocrm

git clone git://github.com/espocrm/espocrm.git
export CRMDIR=$WORKDIR/espocrm
cd $CRMDIR

# Add developer mode to espocrm/data/config.php
echo "<?php return ['isDeveloperMode' => true]; ?>" > $CRMDIR/data/config.php

sudo apt install nodejs npm
npm install -g grunt

# Building node_modules in local machine before mount for development enviornment
npm install

# Compiling less to generate compiled css
grunt less
