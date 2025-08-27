package ui

import (
	"fmt"
	"os"

	tea "github.com/charmbracelet/bubbletea"
)

type multiMenuModel struct {
	prompt   string
	cursor   int
	choices  []string
	selected map[int]bool // index --> selected
	quit     bool
	done     bool
}

func newMultiMenu(prompt string, choices []string) multiMenuModel {
	return multiMenuModel{
		prompt:   prompt,
		cursor:   0,
		choices:  choices,
		selected: make(map[int]bool),
	}
}

func (m multiMenuModel) Init() tea.Cmd {
	return nil
}

func (m multiMenuModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
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

		case " ":
			if m.selected[m.cursor] {
				m.selected[m.cursor] = false
			} else {
				m.selected[m.cursor] = true
			}

		case "enter":
			m.done = true
			return m, tea.Quit
		}
	}
	return m, nil
}

func (m multiMenuModel) View() string {
	if m.quit && !m.done {
		return "Exiting program. Goodbye!\n"
	}

	if m.done {
		var results []string
		for i, choice := range m.choices {
			if m.selected[i] {
				results = append(results, choice)
			}
		}
		return fmt.Sprintf("You selected: %v\n", results)
	}

	s := "\n" + m.prompt + "\n\n"
	for i, choice := range m.choices {
		cursor := " " // null cursor
		if m.cursor == i {
			cursor = "→"
		}

		check := "[ ]"
		if m.selected[i] {
			check = "[✓]"
		}
		s += fmt.Sprintf("%s %s %s\n", cursor, check, choice)
	}

	s += "\nUse ↑/↓ or j/k     [space] - select     [enter] - confirm     q - quit\n"
	return s
}

// TODO:
// Refactor to return an error instead of early exit
func showMultiMenu(prompt string, choices []string) []string {
	p := tea.NewProgram(newMultiMenu(prompt, choices))
	m, err := p.Run()
	if err != nil {
		fmt.Println("Error displaying menu:", err)
		os.Exit(1)
	}

	model := m.(multiMenuModel)
	if model.quit && !model.done {
		return nil
	}

	var results []string
	for i, choice := range model.choices {
		if model.selected[i] {
			results = append(results, choice)
		}
	}

	return results
}
