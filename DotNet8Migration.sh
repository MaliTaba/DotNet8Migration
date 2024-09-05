#!/bin/bash

# Report
echo "Here is the list of all the TargetFramework in this project:"
find . -name "*.csproj" -exec sed -n 's/.*<TargetFramework>\(net[^8].*\)<\/TargetFramework>.*/\1/p' {} +


# Find all .csproj files
find . -name "*.csproj" | while read -r file; do
    # Use sed to replace TargetFramework entries
    sed -i '' -E '
        /<TargetFramework>net[^8]/,/<\/TargetFramework>/ {
            s|<TargetFramework>net[^8][^<]*</TargetFramework>|<TargetFramework>net8.0</TargetFramework>|g
        }
    ' "$file"
    
    echo "Processed: $file"
done

echo "All done!"


# Find all .csproj files in the current directory and subdirectories
find "$(pwd)" -name "*.csproj" | while read -r PROJECT_FILE; do

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
