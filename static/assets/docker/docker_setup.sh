#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]; then

    echo "Script needs to be run as root, please run command using sudo or as the root user!\n"
    exit 1
    fi

if ! command docker -v &> /dev/null;  then

    echo "Docker does not exist on this system. Beginning install of Docker.\n\n"
   
    #Update repositories
    apt update &> /dev/null

    #Install repository dependencies
    apt install -y ca-certificates curl gnupg &> /dev/null
    install -m 0755 -d /etc/apt/keyrings &> /dev/null
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null

    #Update using new repository listings
    apt update

    #Install all docker utilities
    apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    systemctl status docker

    # Add user to the docker group
    echo "Adding $SUDO_USER to the docker group"
    usermod -aG docker $SUDO_USER

    fi

#Check if docker successfully installed
if ! command docker -v &> /dev/null; then

    echo "Installation has failed! Please see docker documentation to attempt manual installation!"
    exit 1

else

    #Create challenge network
    if ! docker network ls | grep -q "challenge_net"; then
        echo "Creating network challenge_net for the challenge machines to reside on."
        docker network create challenge_net
    else
        echo "Docker network challenge_net already exists."
    fi

echo "Please restart your machine then continue on to your challenge. Restarting will ensure your user is in the correct group, and all changes made to the machine are completed."