package main

import (
	"fmt"

	"github.com/mkavanagh-23/goinstallarchlinux/internal/ui"
)

func main() {
	menuChoices := []string{"Choice 1", "Choice 2", "Choice 3"}
	choice := ui.ShowSimpleMenu(menuChoices)
	if choice != "" {
		fmt.Printf("What?")
	} else {
		fmt.Printf("Correct")
	}
}
