#!/bin/bash

CONFIG_FILE="/tmp/gomod_config"

# Load the $gomod variable from the configuration file if it exists
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
  # Confirm the value of $gomod with the user
  read -p "The current value of the Go module is '$gomod'. Is this correct? (y/n): " confirm
  if [ "$confirm" != "y" ]; then
    unset gomod
  fi
fi

# Check if $gomod is set, if not prompt the user and save it
if [ -z "$gomod" ]; then
  read -p "Please enter the name of the Go module: " gomod
  echo "gomod=$gomod" > "$CONFIG_FILE"
fi

# Confirm the value of $gomod
echo "Go module name: $gomod"

# Remove old Go mod file
echo "Removing old Go mod file..."
if rm go.* 2>/dev/null; then
  echo "Old Go mod file removed successfully."
else
  echo "No old Go mod file found to remove."
fi

# Remove old binary if present
echo "Removing old binary...if present"
if [ -f "$gomod" ]; then
  if rm "$gomod"; then
    echo "Old binary removed successfully."
  else
    echo "Error: Failed to remove old binary." >&2
    exit 1
  fi
else
  echo "No old binary found to remove."
fi

# Reinitialize Go module
echo "Reinitializing Go module..."
if go mod init "$gomod"; then
  echo "Go module reinitialized successfully."
else
  echo "Error: Failed to reinitialize Go module." >&2
  exit 1
fi

# Tidy up
echo "Tidying up..."
if go mod tidy; then
  echo "Modules tidied up successfully."
else
  echo "Error: Failed to tidy up modules." >&2
  exit 1
fi

# Build new binary
echo "Building new binary..."
if go build -o "$gomod"; then
  echo "New binary built successfully."
else
  echo "Error: Failed to build new binary." >&2
  exit 1
fi

echo "Script completed successfully."

