package main

import (
	"fmt"
	"os"

	"github.com/mkavanagh-23/goinstallarchlinux/internal/app"
)

func main() {

	// Parse the Arguments
	state, err := app.ParseArgs(os.Args)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	// Main program entry point
	if err := app.Run(state); err != nil {
		fmt.Fprintln(os.Stderr, "Program failed:", err)
		os.Exit(1)
	}
}
