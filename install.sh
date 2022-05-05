#!/bin/sh

# Color Code
RED='\033[0;31m'
RED_HL='\033[1;41m'
GREEN_HL='\033[1;42m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BLUE_HL='\033[1;44m'
YELLOW='\033[0;33m'
YELLOW_HL='\033[1;43m'
NC='\033[0m' # No Color



# OS="$(uname -s)"

# if [ "$OS" = "Linux" ]; then
#   # Add ASCII art for OS
#   printf "\n\n\n$GREEN
#                                                                  #####
#                                                                 #######
#                    #                                            ##O#O##
#   ######          ###                                           #VVVVV#
#     ##             #                                          ##  VVV  ##
#     ##         ###    ### ####   ###    ###  ##### #####     #          ##
#     ##        #  ##    ###    ##  ##     ##    ##   ##      #            ##
#     ##       #   ##    ##     ##  ##     ##      ###        #            ###
#     ##          ###    ##     ##  ##     ##      ###       QQ#           ##Q
#     ##       # ###     ##     ##  ##     ##     ## ##    QQQQQQ#       #QQQQQQ
#     ##      ## ### #   ##     ##  ###   ###    ##   ##   QQQQQQQ#     #QQQQQQQ
#   ############  ###   ####   ####   #### ### ##### #####   QQQQQ#######QQQQQ\n\n\n$NC"

#   printf "${BLUE}Initiating initial setup for Linux operating system.\n${NC}"
#   printf "${RED}This script is tested for following linux distribution.\n 
#   1) Pop!_OS\n 
#   2) Ubuntu\n
#   \n${NC}"
  
#   # Print System info
#   printf "$(egrep '^(VERSION|NAME)=' /etc/os-release)\n\n" 
#   # Ask if user want to go ahead with the setup

#   printf "${YELLOW}Would you like to continue with the Linux initial setup ? [Y/n]${NC}\n"
#   continue_default="y" # Set Y to be default value 
#   read  continue # Read user input
#   continue="${continue:-${continue_default}}" # Assign default value 
#   continue=$(echo $continue | tr '[:upper:]' '[:lower:]')  # Change input to lowercase 
#   # If user in put is not "Y" exit the Script 
#   if [ "$continue" != "y" ] ; then
#   exit 0
#   fi

#   # Update apt before installing 
#   sudo apt update && sudo apt upgrade

#   # Install "TimeShift" backup app
#   printf "${YELLOW}Installing TimeShift application for automated backup snapshot (Similar functionality as Time Machine in MacOS)${NC}\n\n"
  
#   # Install TimeShift for snapshot backup
#   sudo apt-get install timeshift

#   printf "${YELLOW}Installing Flameshot application for taking Screenshot.${NC}\n\n"
#   # Install Flameshot app for screen shot
#   sudo apt-get install flameshot 
#   # Create dir for screenshot if don't exist
#   Screenshots="$HOME/Pictures/Screenshots"
#   if [ ! -d "$Screenshots" ]; then
#     mkdir $Screenshots
#   fi

#   # Install Snap package 
#   printf "${YELLOW}Installing Snap package manager.${NC}\n\n"
#   sudo apt-get install snapd

#   # Installing bitwarden
#   printf "${YELLOW}Installing Bitwarden password manager.${NC}\n\n"
#   sudo snap install bitwarden

#   # Installing Authy 
#   printf "${YELLOW}Installing 2FA Auth TOTP.${NC}\n\n"
#   sudo snap install authy 
#   # Create required directories in system
#   # printf "\n${GREEN}Creating required directories.${NC}\n"

#   # Create default directory for saving Screenshots

#   exit 0
# fi

system_info()
{

  case $(uname -s) in 
  "Linux") 
    . /etc/os-release
    DIST=$NAME
    VER=$VERSION_ID
  
    echo "$DIST and $VER"
    ;;
  "Darwin")
      OIFS="$IFS"
      IFS=$'\n'
      set `sw_vers` > /dev/null
      DIST=`echo $1 | tr "\n:\t\t\t" ' ' | sed 's/ProductName[ ]*//'`
      VER=`echo $2 | tr "\n:\t\t" ' ' | sed 's/ProductVersion[ ]*//'`
      echo "$DIST and $VER"
    ;;
  *)
    # leave ARCH as-is
    return
    ;;
  esac

}

main()
{
  # Detecting System Info
  system_info
  exit 0
}
main