#!/bin/bash

echo "Removing old Go mod file"
rm go.*
echo "Removing old binary...if present"
rm $gomod
echo "Reinitializing Go module"
go mod init $gomod
echo "Tidying up"
go mod tidy
echo "Building new binary"
go build -o $gomod
