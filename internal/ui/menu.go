package ui

// Enumerate the menu types
type MenuType uint8
const (
	SimpleMenu MenuType = iota
	MultiMenu
)

func ShowMenu(menuType MenuType, prompt string, choices []string) []string {
	switch menuType {
	case SimpleMenu:
		return []string{showSimpleMenu(prompt, choices)}
	case MultiMenu:
		return showMultiMenu(prompt, choices)
	default:
		return nil
	}
}