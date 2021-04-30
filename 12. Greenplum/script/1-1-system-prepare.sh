#!/bin/bash

cd $HOME

curl -O https://bootstrap.pypa.io/get-pip.py
python $HOME/get-pip.py --force-reinstall
rm $HOME/get-pip.py

mv $HOME/.bash_profile $HOME/.bash_profile.old

cat >> $HOME/.bash_profile << 'EOF'
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/.local/bin:$HOME/bin:$PATH

EOF

chmod 644 $HOME/.bash_profile
source $HOME/.bash_profile

pip install --upgrade --force-reinstall pip
pip install --upgrade --force-reinstall boto3
pip install --upgrade --force-reinstall awscli
pip install --upgrade --force-reinstall matplotlib

echo "***********************"
echo "* Get AWS CLI version *"
echo "***********************"
aws --version

