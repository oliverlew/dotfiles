#!/bin/sh

# super + d
rofi -theme launcher -show drun

# super + Tab
rofi -show window \
    -kb-cancel "Super+Escape,Escape" \
    -kb-accept-entry '!Super+Tab,!Super_L,!Super+Super_L,!Super+ISO_Left_Tab,Return' \
    -kb-row-down 'Super+Tab,Super+Down,Down' \
    -kb-row-up 'Super+ISO_Left_Tab,Super+Shift+Tab,Super+Up,Up'

# super + Return
st

# super + shift + Return
st -c floating

# super + w
firefox

# super + x
dmenu_run

# super + e
pcmanfm

# super + d
rofi -theme launcher -show drun

# super + ctrl + l
slock

# super + {bracketleft,bracketright,backslash}
dwm-status vol {down,up,toggle}

# XF86Audio{LowerVolume,RaiseVolume,Mute}
dwm-status vol {down,up,toggle}

# super + {minus,equal}
dwm-status light {down,up}

# XF86MonBrightness{Down,Up}
dwm-status light {down,up}

# super + shift + {minus,equal}
mpc -q seek {-,+}10

# super + shift + {bracketright,bracketleft,backslash}
mpc -q {next,prev,toggle}

# @Print
scrot 'Screenshot_%F_%H-%M-%S.png' -e 'mv $f ~/Pictures/'

# ctrl + @Print
scrot -e 'xclip -selection clipboard -t image/png < $f && rm $f'

# shift + @Print
scrot -s --line mode=edge,width=4,color=red,opacity=70 'Screenshot_%F_%H-%M-%S.png' -e 'mv $f ~/Pictures/'

# ctrl + shift + @Print
scrot -s --line mode=edge,width=4,color=red,opacity=70 -e 'xclip -selection clipboard -t image/png < $f && rm $f'

# super + r
rofi -show run

# XF86Display
setmonitor

# super + p
setmonitor

## Translate selected text with translate-shell
## Idea from https://github.com/4lgn/word-lookup
# super + shift + t
st -c floating sh -c "trans \"$(xclip -o)\" | less -R"
