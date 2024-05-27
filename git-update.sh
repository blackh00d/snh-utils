#!/bin/bash

# Script to quickly push updates to a git repo.

git config --global user.email "blackh00d@github.com"
git config --global user.name "Blackh00d"
git add .
git commit -m "Update"
git push origin main
