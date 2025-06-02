#!/bin/bash

# Path to the Godot executable
GODOT_EXEC="$(pwd)/godot_engine"

# Path to the Godot project
PROJECT_PATH="$(dirname $(pwd))"

# Check if the executable exists
if [ -f "$GODOT_EXEC" ]; then
    # Launch Godot with the project path
    $GODOT_EXEC --path $PROJECT_PATH
else
    echo "Godot executable not found in $GODOT_EXEC"
    exit 1
fi

