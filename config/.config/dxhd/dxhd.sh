#!/bin/bash

# super + d
rofi -theme launcher -show drun

# super + Tab
rofi -show window \
    -kb-cancel "Super+Escape,Escape" \
    -kb-accept-entry "!Super+Tab,!Super_L,!Super+Super_L,!Super+ISO_Left_Tab,Return" \
    -kb-row-down "Super+Tab,Super+Down,Down" \
    -kb-row-up "Super+ISO_Left_Tab,Super+Shift+Tab,Super+Up,Up"

# super + Return
## st
tym

# super + shift + Return
## st -c floating
tym --role=floating

# super + w
firefox

# super + e
nemo

# super + d
rofi -theme launcher -show drun

# super + ctrl + l
slock

# super + {bracketleft,bracketright,backslash}
statusctl vol {down,up,mute}

# XF86Audio{LowerVolume,RaiseVolume,Mute}
statusctl vol {down,up,mute}

# super + {minus,equal}
statusctl backlight {down,up}

# XF86MonBrightness{Down,Up}
statusctl backlight {down,up}

# super + shift + {minus,equal}
mpc -q seek {-,+}10

# super + shift + {bracketright,bracketleft}
mpc -q {next,prev}

# super + shift + backslash
statusctl mpd pause

# @Print
scrot "$HOME/Pictures/Screenshot_%F_%H-%M-%S.png"

# ctrl + @Print
tmpfile=$(mktemp -u --tmpdir scrot.temp.XXXX.png)
scrot "$tmpfile"
xclip -selection clipboard -t image/png < "$tmpfile"
rm "$tmpfile"

# shift + @Print
scrot -s --line mode=edge,width=4,color=red,opacity=70 "$HOME/Pictures/Screenshot_%F_%H-%M-%S.png"

# ctrl + shift + @Print
tmpfile=$(mktemp -u --tmpdir scrot.temp.XXXX.png)
scrot -s --line mode=edge,width=4,color=red,opacity=70 "$tmpfile"
xclip -selection clipboard -t image/png < "$tmpfile"
rm "$tmpfile"

# super + r
rofi -show run

# XF86Display
setmonitor

# super + p
setmonitor

# super + shift + p
openrefs

# super + shift + ctrl + p
openpdf

## Translate selected text with translate-shell
## Idea from https://github.com/4lgn/word-lookup
# super + shift + t
st -c floating sh -c "trans \"$(xclip -o)\" | less -R"
