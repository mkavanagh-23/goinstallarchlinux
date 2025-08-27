package app

import (
	"errors"
	"fmt"
)

// ParseArgs takes CLI args and converts them into a ProgramState.
func ParseArgs(args []string) (ProgramState, error) {
	if len(args) != 3 {
		return ProgramState{}, fmt.Errorf(
			"usage: '%s [vanilla|t2] [install|postinstall]'", args[0],
		)
	}

	// Create a state object
	var state ProgramState

	// Distribution
	switch args[1] {
	case "vanilla":
		state.Distribution = ArchVanilla
	case "t2":
		state.Distribution = ArchT2
	default:
		return ProgramState{}, errors.New("Invalid distribution type: " + args[1])
	}

	// Stage
	switch args[2] {
	case "install":
		state.Stage = InitialInstall
	case "postinstall":
		state.Stage = PostInstall
	default:
		return ProgramState{}, errors.New("Invalid installation stage: " + args[2])
	}

	return state, nil
}
