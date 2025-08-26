package ui

import (
	"fmt"
	"os"

	tea "github.com/charmbracelet/bubbletea"
)

type model struct {
	cursor 		int
	choices		[]string
	selected	string
	quit		bool
}

func NewSimpleMenu(choices []string) model {
	return model{
		cursor: 0,
		choices: choices,
	}
}

func (m model) Init() tea.Cmd {
	return nil
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	
	case tea.KeyMsg:
		switch msg.String() {

		case "ctrl+c", "q":
			m.quit = true
			return m, tea.Quit
		}
	}

	return m, nil
}

func (m model) View() string {
	s := "Program build success.\nCtrl-C or 'q' to quit.\n"
	return s
}

func ShowSimpleMenu(choices []string) string {
	p := tea.NewProgram(NewSimpleMenu(choices))
	m, err := p.Run()
	if err != nil {
		fmt.Println("Error displaying menu:", err)
		os.Exit(1)
	}
	return m.(model).selected
}
