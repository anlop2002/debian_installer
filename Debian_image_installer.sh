#!/bin/bash


if [ -z "$STEP" ]; then
echo "STEP=1" >> /etc/environment
printf "\e[1;32m \nWelcome to the i.MX Debian utility installer \n \n\e[m"
printf "Please make sure your board is connected to the internet via the Ethernet port \n"
printf "Press any key to confirm \n"

read -n1 -s temp

printf "Checking Ethernet connection... \n"
#TODO check for ethernet connection
sleep 2
printf "Ethernet connection" 
printf "\e[1;32m ESTABLISHED \n\e[m"
sleep 2

printf "Please choose one of the following installer options: \n"
printf " \e[1;33m \t 1. Developer image: \e[m" 
printf "includes the most common tools for application development \n"
printf " \e[1;33m \t 2. Full utility image + GUI interface : \e[m"
printf "Includes the most common Linux utilities plus the packets to enable the Debian GUI interface \n"

read -n1 -s selection

if [ "$selection" == "1" ]; then
  printf "Installing i.MX developer image... \n"
  printf "Expanding partition to fit new utilities... \n"
  printf "\e[1;32mThe board will reboot after this step \n\e[m"
  echo -e "d\n2\nn\np\n2\n40960\n\n\nw\nq\n" | fdisk /dev/mmcblk2
  printf "Rebooting...\n"
  reboot -f
fi
fi

  printf "Checking partition expansion\n"
#TODO check for new partition size with lsblk --output SIZE /dev/mmcblk2p2
  resize2fs /dev/mmcblk2p2
  printf "Updating exisiting utilities, this might take a while\n"
  apt-get update
  printf "Installing aptitude... \n"
  apt-get install -y aptitude
  printf "\e[1;32mInstalling new utilities:\n\e[m"
#TODO install apps with right package name

  printf "Installing build-essential... \n"
  printf "Installing Nano... \n"
  printf "Installing Vim... \n"
  printf "Installing ddd... \n\n"
  printf "Installing gdb... \n\n"
  printf "Installing git... \n\n"
  printf "Installing exuberant-ctags... \n\n"
  printf "Installing cscope... \n\n"
  printf "Developer image succesfully installed: 8/8 \n\n"

if [ "$selection" == "2" ]; then
  echo "Installing i.MX full utility image..."
#TODO create list and install GUI version utilities
fi

