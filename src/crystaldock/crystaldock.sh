#!/bin/bash

args=$@

EXEC=/opt/crystaldock/bin/crystaldock.py
OUTPUT=./output
DB="/share/apps/crystaldock/microenvironment_database"
OPTS="-microenvironment_database_directory $DB -output_directory $OUTPUT"

cmd="$EXEC $OPTS $args"

echo "Executing $cmd"

# $cmd

