#!bin/bash

sudo apt-get update

#docker install
curl https://get.docker.com | sudo bash
sudo usermod -aG docker jenkins

#docker compose install
# make sure jq & curl is installed
sudo apt update
sudo apt install -y curl jq
# set which version to download (latest)
version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r '.tag_name')
# download to /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# make the file executable
sudo chmod +x /usr/local/bin/docker-compose


#authenitcate docker user with jenkins
echo $DOCKER_PASSWORD | docker login --username aimeeh97 --password-stdin 