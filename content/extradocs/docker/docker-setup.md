+++
title = "Docker Setup"
showFullContent = false
hideComments = true
+++

## Purpose:

This guide will walk students through setting up their docker for use in some of the labs and challenges used within the Weber State Cyber Club. This page will include a script, along with instructions for receiving assistance, and troubleshooting guides.

## Docker:

**What is Docker?** Docker is an open-source containerization platform. It is widely used by developers to create isolated pre-built environments called containers to deploy their products.

**What is a container?** A container is a fully isolated environment that has all the tools, and libraries needed to run a specified product. Containers are often used by developers due to the ability to provide the same environment for their product to run in, every time that it runs. This saves the consumer from running into the issue of "Well it ran on my computer!" We will be using this technology to have a way to easily share a preconfigured environment that students will be able to complete labs and challenges against.

## Our Setup:

In our setup we will be creating a dedicated network within Docker that will contain the machines you are attempting to attack. At the beginning of a challenge that uses docker there will be a link to the setup script that is on this page, as well as a docker pull command and other associated commands to get your docker container fully operational. The hope of this setup is to give students an environment they can attack that is preconfigured, isolated, and easily rebuilt!

## The Script:

The script for the docker setup can be downloaded [here](/Home/assets/docker/docker_setup.sh). The contents of this script will be given below so students can have an idea of what is going on behind the scenes. This script will only work on debian systems, as these challenges are meant to be completed on Kali Linux. However, docker has really good resources for installation on other platforms [here](https://docs.docker.com/engine/install/). Keep in mind this script takes some time to run, so please be patient while it installs all the needed applications. You will need to run "chmod +x docker_setup.sh" in order to run the script, the script would be run as "sudo docker_setup.sh".

## Contents of the Script:
```
#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]; then

    echo "Script needs to be run as root, please run command using sudo or as the root user!"
    exit 1
    fi

if ! command docker -v &> /dev/null;  then

    echo "Docker does not exist on this system. Beginning install of Docker."
   
    #Update repositories
    apt update &> /dev/null

    #Install all docker utilities
    apt install -y docker.io &> /dev/null
    systemctl enable docker --now

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
fi
echo "Please restart your machine then continue on to your challenge. Restarting will ensure your user is in the correct group, and all changes made to the machine are completed."
```

## What Next?

Now that you have completed your environment setup, you are now ready to complete your challenge. Your environment should be fully configured, you should no longer need to run this script!