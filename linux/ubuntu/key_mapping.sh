# Remap keys on the keyboard 

# xev # to get a current key mapping 

example="
KeyRelease event, serial 37, synthetic NO, window 0x4400001,
    root 0x163, subw 0x0, time 147968755, (988,315), root:(1038,429),
    state 0x0, keycode 22 (keysym 0xff08, BackSpace), same_screen YES,
    XLookupString gives 1 bytes: (08)
    XFilterEvent returns: False "

# To replace BackSpace key with Delete key 
xmodmap -e "keycode 22 = Delete"

# To make changes permanent
xmodmap -pke >~/.Xmodmap

# show all keys mapping
sudo dumpkeys
