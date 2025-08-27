package app

import (
	"fmt"

	"github.com/mkavanagh-23/goinstallarchlinux/internal/ui"
)

type DistributionType uint8

const (
	ArchVanilla DistributionType = iota
	ArchT2
)

type InstallationStage uint8

const (
	InitialInstall InstallationStage = iota
	PostInstall
)

type ProgramState struct {
	Distribution DistributionType
	Stage        InstallationStage
}

func debugUI() {
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

func Run(state ProgramState) error {
	fmt.Println("Successfully started program.")
	// Run the installer
	debugUI()
	return nil
}
