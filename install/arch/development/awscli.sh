#!/bin/bash

if ! command -v aws &> /dev/null; then
  cd
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  cd $REPO_DIR
else
  echo "AWS CLI is already installed."
fi