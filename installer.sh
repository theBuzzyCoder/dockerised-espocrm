git clone git://github.com/espocrm/espocrm.git

cd espocrm
# Add developer mode to espocrm/data/config.php
echo "<?php return ['isDeveloperMode' => true]; ?>" > ./data/config.php

sudo apt install nodejs npm
npm install -g grunt

# Building node_modules in local machine before mount for development enviornment
npm install

# Compiling less to generate compiled css
grunt less
