#!/bin/bash

# The easy script for terminal command 
# [sudo apt update && sudo apt dist-upgrade && sudo apt upgrade && sudo apt autoremove && sudo apt autoclean]

printf "\033[32m\nFetch the fresh packages from reposirories\033[0m \n\n"
sudo apt update 

forUpdate=`sudo /usr/lib/update-notifier/update-motd-updates-available`
if [ -n "${forUpdate}" ]; then
    printf "\033[32mUpdate has been completed. Look at the packages for upgrade!\033[0m \n\n"
    printf "\033[32m" && sudo apt list --upgradable && printf "\033[0m \n\n" 

    printf "\033[32mStart the dist-upgrade.\033[0m \n\n"
    sudo apt dist-upgrade -y

    printf "\033[32mThe dist-upgrade has been completed. Start packages upgrade.\033[0m \n\n"
    sudo apt upgrade -y

    printf "\033[32mUpgrade has been completed. Start the clear.\033[0m \n\n"

    sudo apt -y autoremove --purge
    sudo apt -y autoclean
    printf "\033[32mAutoremove and autoclean has been completed.\033[0m \n"
fi

printf "\n\033[32mEverything was updated. Enjoy it!\033[0m \n\n"

if [ -f /var/run/reboot-required ]; then
    printf "\033[31mPlease, reboot your system, it's required!\033[0m \n\n"
fi
