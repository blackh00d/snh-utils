#!/bin/bash

echo "Configuring repo email"
git config --global user.email "blackh00d@github.com"
echo "Configuring repo username"
git config --global user.name "Blackh00d"
echo "Adding recent changes"
git add .
echo "Commiting changes with comment"
git commit -m "Update"
echo "Pushing updates to repo"
git push origin main
