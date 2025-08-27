package ui

import (
	"fmt"
	"os"

	tea "github.com/charmbracelet/bubbletea"
)

type simpleMenuModel struct {
	prompt   string
	cursor   int
	choices  []string
	selected string
	quit     bool
}

func newSimpleMenu(prompt string, choices []string) simpleMenuModel {
	return simpleMenuModel{
		prompt:  prompt,
		cursor:  0,
		choices: choices,
	}
}

func (m simpleMenuModel) Init() tea.Cmd {
	return nil
}

func (m simpleMenuModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {

	case tea.KeyMsg:
		switch msg.String() {

		case "ctrl+c", "q":
			m.quit = true
			return m, tea.Quit

		case "up", "k":
			if m.cursor > 0 {
				m.cursor--
			} else {
				m.cursor = len(m.choices) - 1
			}

		case "down", "j":
			if m.cursor < len(m.choices)-1 {
				m.cursor++
			} else {
				m.cursor = 0
			}

		case "enter":
			m.selected = m.choices[m.cursor]
			return m, tea.Quit
		}
	}
	return m, nil
}

// TODO:
// Update index looping to carry-over from top to bottom
func (m simpleMenuModel) View() string {
	if m.quit && m.selected == "" {
		return "Exiting program. Goodbye!\n"
	}

	if m.selected != "" {
		return fmt.Sprintf("You selected: %s\n", m.selected)
	}

	s := "\n" + m.prompt + "\n\n"
	for i, choice := range m.choices {
		cursor := " " // null cursor
		if m.cursor == i {
			cursor = "→"
		}
		s += fmt.Sprintf("%s %s\n", cursor, choice)
	}

	s += "\nUse ↑/↓ or j/k       [enter]       q - quit\n"
	return s
}

// TODO:
// Refactor to return an error instead of early exit
func showSimpleMenu(prompt string, choices []string) string {
	p := tea.NewProgram(newSimpleMenu(prompt, choices))
	m, err := p.Run()
	if err != nil {
		fmt.Println("Error displaying menu:", err)
		os.Exit(1)
	}
	return m.(simpleMenuModel).selected
}
