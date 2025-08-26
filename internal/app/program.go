package app

import(
	"fmt"
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
	Distribution	DistributionType
	Stage			InstallationStage
}

func ProgramRun(state ProgramState) {
	fmt.Println("Successfully started program.")
	// Run the installer
	return
}