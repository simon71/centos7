#! /bin/bash

#updated, upgrade, and clean
sudo yum -y update
sudo yum -y upgrade
sudo yum -y clean all

pw=$(date +%s | sha256sum | base64 | head -c 32 ; echo)

echo "creating user account simon71"
/usr/sbin/useradd simon71 -g vagrant -G wheel
echo "the password is $pw"
echo "$pw"|passwd --stdin vagrant
echo "simon71        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant
#
# check=$(yum list installed | grep vim)
#
# if [ -z "$check" ]; then
# 	echo "installing vim..."
# 	sudo yum -y install vim
# else
# 	echo "vim already installed"
# fi
#
# # add me as user
# /usr/sbin/useradd simon71 -g vagrant -G wheel
# echo
#
# # copy to home folder
# cp centos7/.vimrc ~/.vimrc
#
# cp centos7/autoload ~/.vim/autoload
#
# # Install pathogen
# mkdir -p ~/.vim/autoload ~/.vim/bundle
# curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim --insecure
#
# # install nerdtree
# git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
# #update PS1 cant get it to work
# P1="\[\033[1;93m\] \\A \\u \\w \[\033[0;96m\]$\[\033[0;37m\]"
