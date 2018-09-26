if [ -x "$(which docker)" ]; then
  echo "docker not found. Install docker first ..."
  exit
fi

if [ -x "$(which docker-compose)" ]; then
  echo "docker-compose not found. Installing it now ..."
  sudo apt install docker-compose
fi

export WORKDIR=$HOME/dockerised-espo
mkdir -p $WORKDIR

if [ -d $WORKDIR/php7.2-espocrm ]; then
  echo "php directory found";
else
  git clone git://github.com/theBuzzyCoder/dockerised-espo.git $WORKDIR
fi

cd $WORKDIR/php7.2-espocrm

git clone git://github.com/espocrm/espocrm.git
export CRMDIR=$WORKDIR/php7.2-espocrm/espocrm
cd $CRMDIR

# Add developer mode to espocrm/data/config.php
echo "<?php return ['isDeveloperMode' => true]; ?>" > $CRMDIR/data/config.php

sudo apt install nodejs npm
sudo npm install -g grunt

# Building node_modules in local machine before mount for development enviornment
sudo npm install

# Compiling less to generate compiled css
grunt less
