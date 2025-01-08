#!/bin/bash

# Setup linux dependencies
su -c 'apt-get update && apt-get install sudo'
sudo apt-get install -y less nano htop ncdu

# Setup virtual environment
pip install uv
uv venv
uv pip install simple-gpu-scheduler ipykernel # very useful on runpod with multi-GPUs https://pypi.org/project/simple-gpu-scheduler/
source ./venv/bin/activate
python -m ipykernel install --user --name=venv

# Install gh and login
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh
gh auth login --with-token

git config --global user.email "rowankwang@gmail.com"
git config --global user.name "Wanff"

# Setup dotfiles and ZSH
cd dotfiles
./install.sh --zsh --tmux
./deploy.sh
cd ..
chsh -s /usr/bin/zsh

# 5) Project specific setup (uncomment and fill out)gh
# git clone <github_url>
# cd <repo_name>
# pip install -r requirements.txt