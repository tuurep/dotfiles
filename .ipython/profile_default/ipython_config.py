from IPython.terminal.prompts import Token

ipy_config = get_config()

fg = '#c5c8c6'
green = '#b5bd68'
red = '#cc6666'

ipy_config.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: green,
    Token.PromptNum: green,
    Token.OutPrompt: red,
    Token.OutPromptNum: red
}

c.TerminalInteractiveShell.highlighting_style = 'base16tomorrownightmod'
c.TerminalInteractiveShell.highlight_matching_brackets = False
