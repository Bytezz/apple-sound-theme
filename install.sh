#!/bin/bash

window_title="Apple Sound Theme"
ask_user_installation="Install Apple XDG Sound Theme for current user?"
successfull_installation="Installation completed."
failed_installation="Installation failed."

useKdialog=false
if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
	useKdialog=true
fi

install_path="/tmp/.local/share/sounds/apple-sound-theme"

if $useKdialog ;then
	kdialog --title "$window_title" --yesno "$ask_user_installation"
	answer=$?
else
	zenity --question --title "$window_title" --text "$ask_user_installation"
	answer=$?
fi

if [ $answer -eq 0 ]; then
	cd "$(readlink -f "$(dirname "$0")")"

	mkdir -p "$install_path" && cp -r * "$install_path"
	answer=$?

	if [ $answer -eq 0 ]; then
		if $useKdialog ;then
			kdialog --title "$window_title" --msgbox "$successfull_installation"
		else
			zenity --title "$window_title" --info --text "$successfull_installation" --icon-name=object-select-symbolic
		fi
	else
		if $useKdialog ;then
			kdialog --title "$window_title" --error "$failed_installation Error code $answer."
		else
			zenity --title "$window_title" --error --text "$failed_installation Error code $answer."
		fi
	fi
fi
