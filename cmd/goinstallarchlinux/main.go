package main

import (
	"fmt"
	"os"

	"github.com/mkavanagh-23/goinstallarchlinux/internal/ui"
	//"github.com/mkavanagh-23/goinstallarchlinux/internal/app"
)

type distributionType uint8
const (
	archVanilla distributionType = iota
	archT2
)

type installationStage uint8
const (
	initialInstall installationStage = iota
	postInstall
)

type programState struct {
	distribution	distributionType
	stage			installationStage
}

var state programState

func main() {
	// Check for valid arguments
	if len(os.Args) != 3 {
		fmt.Printf("Usage: '%s [vanilla|t2] [install|postinstall]'\n", os.Args[0])
		return
	}
	distroType := os.Args[1]
	fmt.Printf("Distro type: %s\n", distroType)
	installStage := os.Args[2]
	fmt.Printf("Install stage: %s\n", installStage)

	// Extract the state
	switch distroType {
	case "vanilla":
		state.distribution = archVanilla
	case "t2":
		state.distribution = archT2
	default:
		fmt.Printf("Invalid distribution type provided: %s\n", distroType)
		return
	}
	switch installStage {
	case "install":
		state.stage = initialInstall
	case "postinstall":
		state.stage = postInstall
	default:
		fmt.Printf("Invalid installation stage provided: %s\n", installStage)
		return
	}

	// Run the program from the current state
	// func programRun(state programState) { }

	/******* DEBUG TESTING BELOW *******/
	// Test generation of different menu types
	menuChoices := []string{"Choice 1", "Choice 2", "Choice 3"}
	simplePrompt := "Select your desired option:"
	multiPrompt := "Select your desired option(s):"

	simpleReturn := ui.ShowMenu(ui.SimpleMenu, simplePrompt, menuChoices)
	if simpleReturn[0] == "" {
		fmt.Println("No simple choice selected.")
	} else {
		fmt.Println("Single choice selection:")
		for _, value := range simpleReturn {
			fmt.Println("-", value)
		}
	}

	multiReturn := ui.ShowMenu(ui.MultiMenu, multiPrompt, menuChoices)
	if len(multiReturn) == 0 {
		fmt.Println("No multiple choice selected.")
	} else {
		fmt.Println("Multiple choice selections:")
		for _, value := range multiReturn {
			fmt.Println("-", value)
		}
	}
}
