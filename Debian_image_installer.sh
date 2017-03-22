#!/bin/bash


if [ -z "$STEP" ]; then
echo "STEP=1" >> /etc/environment
printf "\e[1;32m \nWelcome to the i.MX Debian utility installer \n \n\e[m"
printf "Please make sure your board is connected to the internet via the Ethernet port \n"
printf "Press any key to confirm \n"

read -n1 -s temp

printf "Checking Ethernet connection... \n"

wget -q --spider http://debian.org
if [ $? -eq 0 ]; then
  printf "\e[1;32m \nEthernet connection established \n\n\e[m"
else
  printf "\e[1;31m \nPlease check your Ethernet connection and try again \n\n\e[m"
fi
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
  echo -e "d\n2\nn\np\n2\n40960\n\n\nw\nq\n" | fdisk /dev/mmcblk2 > /dev/null
  printf "Rebooting...\n"
  reboot -f
fi
fi

  printf "Checking partition expansion\n"
#TODO check for new partition size with lsblk --output SIZE /dev/mmcblk2p2
  resize2fs /dev/mmcblk2p2 > /dev/null
  printf "Updating existing utilities, this might take a while\n"
  apt-get update > /dev/null
  printf "Installing aptitude... \n"
  apt-get install -y aptitude > /dev/null
  printf "\e[1;32mInstalling new utilities:\n\e[m"

  printf "Installing build-essential... \n"
  aptitude install -y build-essential > /dev/null
  printf "Installing Nano... \n"
  aptitude install -y nano > /dev/null
  printf "Installing Vim... \n"
  aptitude install -y vim > /dev/null
  printf "Installing ddd... \n"
  aptitude install -y ddd > /dev/null
  printf "Installing gdb... \n"
  aptitude install -y gdb > /dev/null
  printf "Installing git... \n"
  aptitude install -y git > /dev/null
  printf "Installing exuberant-ctags... \n"
  aptitude install -y exuberant-ctags > /dev/null
  printf "Installing cscope... \n"
  aptitude install -y cscope > /dev/null
  printf "Developer image successfully installed: 8/8 \n\n"

if [ "$selection" == "2" ]; then
  echo "Installing i.MX full utility image..."
#TODO create list and install GUI version utilities
fi

