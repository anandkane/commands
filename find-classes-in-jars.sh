#!/bin/bash

# Function to display usage message
usage() {
    echo "Usage: $0 <classes_file> <jars_folder>"
    echo "  <classes_file>: File containing the list of classes to search for"
    echo "  <jars_folder>: Folder containing the JAR files to search in"
    exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    usage
fi

# Assign arguments to variables
classes_file="$1"
jars_folder="$2"

# Check if the classes file exists
if [ ! -f "$classes_file" ]; then
    echo "Error: Classes file '$classes_file' not found."
    exit 1
fi

# Check if the JARs folder exists
if [ ! -d "$jars_folder" ]; then
    echo "Error: JARs folder '$jars_folder' not found."
    exit 1
fi

# Read classes from the specified file into an array
mapfile -t classes < "$classes_file"

# Create an associative array to keep track of attempted classes
declare -A attempted

# Initialize attempted classes array with all classes set to false
for class in "${classes[@]}"; do
    attempted["$class"]=false
done

# Initialize the counter for attempted classes
attempted_count=0
total_classes=${#classes[@]}

# Convert class names to paths
declare -A class_paths
for class in "${classes[@]}"; do
    class_paths["$class"]=$(echo "$class" | tr '.' '/')".class"
done

# Iterate over each JAR in the specified folder
for jar in "$jars_folder"/*.jar; do
    # List the contents of the JAR file once
    jar_contents=$(jar tf "$jar")

    # Check each class in the JAR contents
    for class in "${classes[@]}"; do
        # Skip if the class is already found
        if [ "${attempted[$class]}" = true ]; then
            continue
        fi

        # Check if the class exists in the JAR contents
        if echo "$jar_contents" | grep -q "${class_paths[$class]}"; then
            echo "$class found in $jar"
            attempted["$class"]=true
            ((attempted_count++))

            # Break early if all classes have been attempted
            if [ "$attempted_count" -eq "$total_classes" ]; then
                break 2
            fi
        fi
    done
done
