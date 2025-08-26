#!/usr/bin/env bash

outputfile="bin/goinstallarchlinux"

echo "Building project to $outputfile"
go build -o bin/goinstallarchlinux ./cmd/goinstallarchlinux
if [ $? -eq 0 ]; then
    echo "Build successful. './$outputfile' to run."
else
    echo "Build failed."
fi