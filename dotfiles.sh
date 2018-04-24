#!/usr/bin/env sh

help()
{
    echo -e "sh dotfiles.sh [-f <file>] [test] dump/load [<from> [<to>]]

-f filelist: If given, the file <file> will be used instead of default
    'filelist'.

test: If given, just treat ./test folder as \$HOME so it won't mess up
    the home directory. Mainly for testing.

dump: create link file in target location, used when setting up a new system
    dump:
        read from filelist
    dump <from>:
        <from> should be a local file.
        The script will scan through filelist looking for the same file and
        determine the correspounding target location.
    dump <from> <to>:
        <from> should be a local file, <to> should be a relative path to \$HOME.
        The script will create a link file to <from> at location <to>.

load: move a target file to repo directory, used when adding a new file/folder
    load:
        With no <from> argument, the script will scan 'filelist' file to look
        for files that are not loaded to local repo and load them.
    load <from>:
        <from> should be a relative path to \$HOME. The script will move the
        <from> file to current repo directory and rename it without prefixing
        '.' and folder path.
        e.g.
            <from>: \$HOME/.vimrc       -> vimrc
            <from>: \$HOME/.config/mpv  -> mpv
    load <from> <to>
        manually specify the local file/directory name with <to>. The rest is
        the same as without <to>."
}

usage()
{
    echo -e "Usage:
    sh dotfiles.sh [-f <file>] [test] dump/load [<from> [<to>]]

For more information, see 'sh dotfiles.sh help'"
}

load()
{
    originalfile=$1
    basefile=$(basename $1)
    localefile=${basefile#*.}
    mv $originalfile $localefile
}

dump()
{
    link $PWD/$1 $d/$2
}

link()
{
    if [ -e $2 ]
    then
        # check if there is already a symlink to the target, skip
        if [ -L $2 -a "$(readlink $2)" = $1 ]
        then
            printf "[Skipping]: Exists already, $2 -> $1\n"
        # it is already a symlink but to different target, backup by default
        elif [ -L $2 -a "$(readlink $2)" != $1 ]
        then
            printf "[Conflict]: $2 is a symlink but pointing to `readlink $2`, "
            printf "do you want to replace it?\n"
            printf "Backup[B], Replace[r], Skip[s]: "
            read -r respond
            [ x$respond = "x" ] && respond=b
        # it is a normal file or folder, replace by default(treat it as old file, replace with new)
        else
            if [ -d $2 ]
            then
                printf "[Conflict]: The folder $2 exists already, "
            elif [ -f $2 ]
            then
                printf "The file $2 exists already, "
            fi
            printf "do you want to replace it?\n"
            printf "Backup[b], Replace[R], Skip[s]: "
            read -r respond
            [ x$respond = "x" ] && respond=r
        fi

        # Backup file
        if [ x$respond = "xb" ]
        then
            echo "[Back up ]: $2 -> $2.bak"
            rm -rf $2.bak
            mv $2 $2.bak
            makelink $1 $2
        fi

        # Replace file
        if [ x$respond = "xr" ]
        then
            rm -rf $2
            makelink $1 $2
        fi
    else
        makelink $1 $2
    fi
}

makelink()
{
    mkdir -p $(dirname $2)
    echo "[Linking ]: $2 -> $1"
    ln -sf $1 $2
}


testdir=./test
filelist=filelist

if [ x$1 = "x-f" ]
then
    filelist=$2
    shift 2
fi

if [ x$1 = "xtest" ]
then
    d=$testdir
    shift
else
    d=$HOME
fi

case x$1 in
    "xdump"|"xload")
        grep -v '^#' $filelist | while read from to
        do
            case x$1 in
                "xdump")
                    dump $from $to
                    ;;
                "xload")
                    load $from $to
                    ;;
            esac
        done
        ;;
    "xhelp")
        help
        exit 0
        ;;
    *)
        usage
        exit 0
esac

