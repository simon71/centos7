#! /bin/bash

#updated, upgrade, and clean
sudo yum -y update
sudo yum -y upgrade
sudo yum -y clean all

# random passwrod geneartor
pw=$(date +%s | sha256sum | base64 | head -c 8 ; echo)

# check if simon71 already exists
usr=$(cat /etc/passwd | grep simon71)

hmdir=/home/simon71/

cent=/home/simon71/centos7

# if usr is empty then create account
if [ -z $usr ];
then
	echo "creating user account simon71"
	# creats simon71 and adds to vagrant and wheel groups
	/usr/sbin/useradd simon71 -g vagrant -G wheel
	# echo passwrd to sceen for me to copy
	echo "the password is $pw"
	# update passwd for simon71
	echo "$pw"|passwd --stdin vagrant
	# disable passwd for simon71
	echo "simon71        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant

	chmod 0440 /etc/sudoers.d/vagrant
else
	echo "the user simon71 already exists"
fi

echo "copying centos7 to $cent"
# copy file to simon71 home dir
sudo cp -r /home/vagrant/git/centos7/ $hmdir && sudo chown simon71:mainAdmin $hmdir

if [[ -e $cent ]]; then
	echo "Dir copied sucessfully"
else
	echo "Dir failed to copy"
	exit 1
fi

sudo su simon71
echo "changed to $USER"

cd $hmdir

# Check if vim is installed
check=$(yum list installed | grep vim)

# if not install
if [ -z "$check" ]; then
	echo "installing vim..."
	sudo yum -y install vim
else
	echo "vim already installed"
fi

# copy to home folder
cp $cent/vim/.vimrc $hmdir.vimrc

cp centos7/autoload ~/.vim/autoload

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim --insecure

# install nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#update PS1 cant get it to work
P1="\[\033[1;93m\] \\A \\u \\w \[\033[0;96m\]$\[\033[0;37m\]"
