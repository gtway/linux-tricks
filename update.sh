#!/bin/bash

# The easy script for terminal command 
# [sudo apt update && sudo apt dist-upgrade && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean]

if ! ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    printf "\033[31m\nDon't have an internet connectivity! Terminated.\033[0m \n\n"
    exit
fi

printf "\033[32m\nFetch the fresh packages from reposirories\033[0m \n"
sudo apt update 

forUpdate=`sudo /usr/lib/update-notifier/update-motd-updates-available`
isFlatpakInstalled=`dpkg-query -W flatpak`
flatpakRegexp="^(flatpak.*)$"

if [ -n "${forUpdate}" ]; then
    printf "\033[32mUpdate has been completed. Look at the packages for upgrade!\033[0m \n\n"
    printf "\033[32m" && sudo apt list --upgradable && printf "\033[0m \n\n" 

    printf "\033[32mStart the dist-upgrade.\033[0m \n\n"
    sudo apt dist-upgrade -y

    printf "\033[32mThe dist-upgrade has been completed. Start packages upgrade.\033[0m \n\n"
    sudo apt upgrade -y

    printf "\033[32mUpgrade has been completed.\n"
fi

if [[ ${isFlatpakInstalled} =~ $flatpakRegexp ]]; then
    printf "\n\033[32mUpgrade the Flatpak package manager.\033[0m \n"
    sudo flatpak update
fi

printf "\033[32m\nClear the system packages.\033[0m \n"
sudo apt -y autoremove --purge
sudo apt -y autoclean
printf "\033[32mAutoremove and autoclean has been completed.\033[0m \n\n"

printf "\033[32mEverything was updated. Enjoy it!\033[0m \n\n"

if [ -f /var/run/reboot-required ]; then
    printf "\033[31mPlease, reboot your system, it's required!\033[0m \n\n"
fi
sudo -k # exit from sudo rights
