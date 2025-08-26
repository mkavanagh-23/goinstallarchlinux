package ui

type sessionState int

// Define UI view states
const (
	menuView sessionState = iota
	multiChoiceView
	inputView
)
