# Disable access control for the current user
xhost +SI:localuser:$USER

# Make Java applications aware this is a non-reparenting window manager
export _JAVA_AWT_WM_NONREPARENTING=1

# Set default cursor
xsetroot -cursor_name XC_crosshair

# Set keyboard repeat rate
xset r rate 200 60

# Set some keys
setxkbmap -option caps:super

# Start emacs
exec dbus-launch --exit-with-session emacs --debug-init
