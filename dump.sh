#!/usr/bin/env sh
link()
{
	if [ -e $2 ]
	then
		echo -e "The file $2 exists already, do you want to replace it?\nBackup[b], No[n], Replace[r]"
		read respond
	fi
	
	if [ x$respond = "xb" ]
	then
		echo "Backing up $2 as $2.bak"
		mv $2 $2.bak
	fi
	
	if [ ! -e $2 -o x$respond = "xr" ]
	then
		mkdir -p $(dirname $2)
		echo "Creating link $2 -> $1"
		ln -sf $PWD/$1 $2
	fi	
}

if [ x$1 = "xtest" ]
then
	d=./test
else
	d=~
fi

link bashrc $d/.basrhc
link mpv $d/.config/mpv
link aria2.conf $d/.config/aria2/aria2.conf
