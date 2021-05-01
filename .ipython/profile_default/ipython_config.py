from IPython.terminal.prompts import Token

green = '#b5bd68'
red = '#cc6666'

c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: green,
    Token.PromptNum: green,
    Token.OutPrompt: red,
    Token.OutPromptNum: red
}

c.TerminalInteractiveShell.highlighting_style = 'base16tomorrownightmod'
c.TerminalInteractiveShell.highlight_matching_brackets = False
