#!/bin/bash -i

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo 'Installing system dependencies for linux'
  sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
	  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
	  xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'Installing system dependencies for OSX'
  brew install readline xz
else
  echo 'Unknown platform: cannot install system dependencies'
  exit 1
fi

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo '# Start of Python env setup ----------------------------' >> ~/.bashrc
echo 'export PATH="/home/yitong/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc
pyenv install 3.5.6

# System python version
pyenv global 3.5.6
curl https://bootstrap.pypa.io/get-pip.py | python3
pip install --user pipenv
pip install --user -r requirements.txt
echo 'eval "$(pipenv --completion)"' >> ~/.bashrc
echo '# End of Python env setup ------------------------------' >> ~/.bashrc
source ~/.bashrc

cp 00-detect-virtualenv-sitepackages.py ~/.ipython/profile_default/startup/00-venv-sitepackages.py
