package main

import (
	"fmt"

	"github.com/mkavanagh-23/goinstallarchlinux/internal/ui"
)

func main() {
	menuChoices := []string{"Choice 1", "Choice 2", "Choice 3"}
	choice := ui.ShowSimpleMenu(menuChoices)
	if choice != "" {
		fmt.Printf("Your choice: %s\n", choice)
	} else {
		fmt.Println("No choice selected")
	}

	multiChoice := ui.ShowMultiMenu(menuChoices)
	fmt.Printf("Your choices: %v\n", multiChoice)
}
