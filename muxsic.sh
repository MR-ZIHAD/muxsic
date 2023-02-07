 black="\033[0;30m"
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
blue="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
white="\033[0;37m"
nc="\033[00m"

clear

export DIR="$HOME/Music"

clear

echo -e "${green} __  __           ____  _
${green}|  \/  |_   _ ___|  _ \| | __ _ _   _  ___ _ __
${green}| |\/| | | | / __| |_) | |/ _' | | | |/ _ \ '__|
${green}| |  | | |_| \__ \  __/| | (_| | |_| |  __/ |
${green}|_|  |_|\__,_|___/_|   |_|\__,_|\__, |\___|_|
${green}                                |___/
${green}                               [BY MR-RAFI]${green}
"

loop=true

while $loop; do
	trap '' 2
	read -p "muxsic> " cmd
	if [ "$cmd" = "help" ]; then
		echo -e "List of commands:
> list           show playlist

> play <number>  play music

> play all       play all music on playlist

> chdir <path>   change playlist directory

> help           show this help

> exit           exit from this program\n"
	elif [ "$cmd" = "list" ]; then
		getlist=$(ls $DIR | grep mp3)
		replace=${getlist// /%%}
		n=1
		for music in $replace; do
			echo "[$n] ${music//%%/ }"
			((n++))
		done
		echo
	elif echo "$cmd" | grep -q "play"; then
		arg=$(echo "$cmd" | cut -d " " -f 2)
		getlist=$(ls $DIR | grep mp3)
		replace=${getlist// /%%}
		list=()
		for m in $replace; do
			list+=("$m")
		done
		if [ $arg = "all" ]; then
			for ms in $replace; do
				trap 'break' 2
				mpv "$DIR/${ms//%%/ }"
			done
		else
			music=${list[(($arg-1))]}
			mpv "$DIR/${music//%%/ }"
		fi
		echo
	elif echo "$cmd" | grep -q "chdir"; then
		export DIR="$(echo "$cmd" | cut -d " " -f 2)"
		echo "Directory changed!"
		echo
	elif [ "$cmd" = "exit" ]; then
		loop=false
	else
		echo "W000t?? please type \"help\""
	fi
done
