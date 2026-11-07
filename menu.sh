#!/bin/bash
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

IP=$(curl -s ipv4.icanhazip.com)

create_ssh_user() {
    clear
    echo -e "${CYAN}=== CREATE SSH / WS / UDP USER ===${NC}"
    read -p "Username : " Login
    read -p "Password : " Pass
    read -p "Expired (Days) : " masaaktif

    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    useradd -e "$exp" -s /bin/false -M "$Login"
    echo -e "$Login:$Pass" | chpasswd

    echo -e "${GREEN}User Successfully Created!${NC}"
    echo -e "Username : $Login | Expires: $exp"
    read -n 1 -s -r -p "Press any key to return..."
}

while true; do
    clear
    echo -e "${CYAN}=================================${NC}"
    echo -e "   VPS MANAGEMENT MENU - IP: $IP"
    echo -e "${CYAN}=================================${NC}"
    echo -e " [1] Create SSH/WS/UDP User"
    echo -e " [2] Exit"
    read -p " Select Option: " opt

    case $opt in
        1) create_ssh_user ;;
        2) exit 0 ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac
done
