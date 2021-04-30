#!/bin/bash
  
source $HOME/init_gp_demo_var

cd $HOME

if [ "$(pip list -o | grep -E '^pip.*$' | awk '{print $2}')" != "" ]
then
  curl -O https://bootstrap.pypa.io/get-pip.py
  python $HOME/get-pip.py --user

  rm $HOME/get-pip.py

  pip install --upgrade --force-reinstall --user pip
else
  pip --version
fi

if [ "$(pip list -o | grep -E '^jupyter\s+.*$' | awk '{print $2}')" != "" ]
then
  pip install --upgrade --user jupyter
fi

if pip list -o | grep -E '^pygments\s+.*$' | awk '{print $2}'
then
  pip install --upgrade --force-reinstall --user pygments
fi

if [ -d $GP_DEMO_DIR ]
then
  cd $GP_DEMO_DIR
  git pull
else
  mkdir $GP_DEMO_DIR
  cd $GP_DEMO_DIR
  git clone https://github.com/cantzakas/gp-demo.git
fi

cd $HOME
