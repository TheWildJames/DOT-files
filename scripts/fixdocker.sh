#!/bin/bash

clear
echo "Enter 1 to install docker"
echo "Enter 2 to remove docker"
echo "Enter 3 to fix perms"
echo "Enter 4 to NUKE"
read -p "Enter (1 2 3 4 E): " fd
if [ "$fd" == "1" ]
then
    sudo pacman -S docker
    sudo systemctl enable --now docker.service
    sudo systemctl enable --now containerd.service
    sudo groupadd docker
    sudo usermod -aG docker james
    newgrp docker
    docker run hello-world
    echo "Docker Install Complete"
elif [ "$fd" == "2" ]
then
    sudo systemctl disable --now docker.service
    sudo systemctl disable --now containerd.service
    sudo pacman -R docker
    echo "Docker Remove Complete"
elif [ "$fd" == "3" ]
then
    sudo chmod g+rwx "$HOME/.docker" -R
    echo "Docker Perms Updated"
elif [ "$fd" == "4" ]
then
    read -p "Are you sure you want to NUKE (Y): " nd
    if [ "$nd" == "Y" ] || [ "$nd" == "y" ]
    then
        for (( i=30; i>0; i--))
        do
            clear
            echo "#########################################################" | lolcat
            echo "# NUKING DOCKER -> $i seconds <- HIT ANY KEY TO CANCEL. #" | lolcat
            echo "#########################################################" | lolcat
            read -t 1 -n 1
            if [ $? = 0 ]
            then
                echo ""
                echo "NUKE ABORTED"
                echo "Exiting"
                exit
            fi
        done
        docker system prune
        sudo systemctl disable --now docker.service
        sudo systemctl disable --now containerd.service
        sudo pacman -R docker
        sudo rm -Irf /var/lib/docker
        sudo rm -Irf ~/.docker
        echo "################" | lolcat
        echo "# DOCKER NUKED #" | lolcat
        echo "################" | lolcat
    else
        echo "NUKE ABORTED"
    fi
elif [ "$fd" == "e" ] || [ "$fd" == "E" ]
then
    echo "Exiting"
else
    echo "No Choice Exiting"
fi
