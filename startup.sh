#! /bin/bash

#updated, upgrade, and clean
sudo yum -y update
sudo yum -y upgrade
sudo yum -y clean all

sudo yum -y install vim git

cd ~

sudo mkdir git
git
cd git/

# fetch .vimrc
sudo git clone https://github.com/simon71/centos7.git

# copy to home folder
cp centos7/.vimrc ~/.vimrc

cp centos7/autoload ~/.vim/autoload

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim --insecure

# install nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
