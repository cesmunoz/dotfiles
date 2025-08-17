#!/bin/bash

if ! command -v aws &> /dev/null; then
  cd
  curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
  sudo installer -pkg AWSCLIV2.pkg -target /
  cd $REPO_DIR
else
  echo "AWS CLI is already installed."
fi