#!/bin/bash

# Find all .csproj files in the current directory and subdirectories
find "$(pwd)" -name "*.csproj" | while read -r PROJECT_FILE; do

    if grep -q "<TargetFramework>net6" "$PROJECT_FILE"; then

        echo "Processing: $PROJECT_FILE"

        # Update TargetFramework to net8.0
        # in Mac use ''
        sed -i '' 's/<TargetFramework>net6\.0<\/TargetFramework>/<TargetFramework>net8.0<\/TargetFramework>/g' "$PROJECT_FILE"

        echo "Updated: $PROJECT_FILE"
        echo "------------------------"
    fi

    # Find all lines containing the word "runtime"
    if grep -q "runtime" "$PROJECT_FILE"; then
        echo "runtime found"
        grep -n "runtime" "$PROJECT_FILE"
        echo "------------------------"
    fi

done

# change the runtime 6 to runtime 8
find "$(pwd)" -name "*.tf" | while read -r TF_File; do

    # Find all lines containing the word "runtime"
    if grep -q "runtime" "$TF_File"; then
        echo "runtime found"
        grep -n "runtime" "$TF_File"
        echo "------------------------"
    fi

done

echo "All .csproj and .tf files have been processed"
