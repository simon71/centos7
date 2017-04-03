#! /bin/bash

#updated, upgrade, and clean
sudo yum -y update
sudo yum -y upgrade
sudo yum -y clean all

sudo yum -y install vim

cd ~

sudo mkdir git

cd git/

# fetch .vimrc
sudo git clone https://github.com/simon71/centos7.git

# copy to home folder
cp centos7/.vimrc ~/.vimrc

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim --insecure
