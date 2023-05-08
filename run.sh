#!/bin/bash

# clone the updated repo
# git clone https://github.com/danbrown/docker-runpod-sd-api.git api

# install the requirements, it is already installed in the docker image, but just in case
# pip install -r api/requirements.txt

# pull the latest changes
cd ./api && git pull && cd ..

