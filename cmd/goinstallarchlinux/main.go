package main

import (
	"os"

	"github.com/charmbracelet/log"
	"github.com/mkavanagh-23/goinstallarchlinux/internal/app"
)

func main() {

	// Parse the Arguments
	state, err := app.ParseArgs(os.Args)
	if err != nil {
		log.Error("Failed to parse arguments", "err", err)
		os.Exit(1)
	}

	// Main program entry point
	if err := app.Run(state); err != nil {
		log.Error("Program failed", "err", err)
		os.Exit(1)
	}
}
