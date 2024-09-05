#!/bin/bash

# Color codes for messages
BOLD="\033[1m"
UNDERLINE="\033[4m"
LIGHT_BLUE="\033[1;34m"     # Light Blue for primary messages
BRIGHT_GREEN="\033[1;32m"   # Bright Green for success messages
MAGENTA="\033[1;35m"        # Magenta for titles
RESET="\033[0m"             # Reset to default color

echo -e "${MAGENTA}Starting installation...${RESET}"

# Update package list
echo -e "${LIGHT_BLUE}Updating package list...${RESET}"
sudo apt update

# Install Git
echo -e "${LIGHT_BLUE}Installing Git...${RESET}"
sudo apt install git -y

# Install required packages
echo -e "${LIGHT_BLUE}Installing required packages...${RESET}"
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common jq -y

# Add Docker repository and install Docker
echo -e "${LIGHT_BLUE}Adding Docker repository...${RESET}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
echo -e "${LIGHT_BLUE}Installing Docker...${RESET}"
sudo apt-get install docker-ce -y

# Clone the repository
echo -e "${LIGHT_BLUE}Cloning Allora Chain repository...${RESET}"
git clone -b main https://github.com/allora-network/allora-chain.git

# Navigate to the cloned directory
cd allora-chain

# Replace requirements.txt with docker-compose.yaml
echo -e "${LIGHT_BLUE}Replacing requirements.txt with docker-compose.yaml...${RESET}"
rm -rf requirements.txt
wget -q https://raw.githubusercontent.com/0xtnpxsgt/Allora-Comprehensive-Guide/main/docker-compose.yaml -O /root/allora-chain/docker-compose.yaml

# Pull and start Docker containers
echo -e "${LIGHT_BLUE}Pulling Docker images and starting containers...${RESET}"
docker compose pull
docker compose up -d

echo -e "${BRIGHT_GREEN}Installation complete!${RESET}"
echo -e "Run ${BOLD}docker compose logs -f${RESET} to check logs."
