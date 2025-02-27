#!/bin/bash

# Setup linux dependencies
su -c 'apt-get update && apt-get install sudo'
sudo apt-get install -y less nano htop ncdu
sudo apt install -y vim 
# Setup virtual environment
cd /workspace
pip install uv
uv venv
uv pip install simple-gpu-scheduler ipykernel # very useful on runpod with multi-GPUs https://pypi.org/project/simple-gpu-scheduler/
source .venv/bin/activate
python -m ipykernel install --user --name=venv

# Install gh and login
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install -y gh
gh auth login

git config --global user.email "rowankwang@gmail.com"
git config --global user.name "Wanff"

# 1) makes the other writable files not have atrocious colors
dircolors -p > ~/.dircolors
echo "OTHER_WRITABLE 37;42" >> ~/.dircolors
eval "$(dircolors -b ~/.dircolors)"

# Setup dotfiles and ZSH
cd ~/dotfiles
./install.sh --zsh --tmux
./deploy.sh
cd ..
chsh -s /usr/bin/zsh

# 5) Project specific setup (uncomment and fill out)gh
# git clone <github_url>
# cd <repo_name>
# pip install -r requirements.txt
