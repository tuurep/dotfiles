import IPython
import prompt_toolkit
from IPython.terminal.prompts import Token
from prompt_toolkit.styles.style import Style
from prompt_toolkit.styles.pygments import pygments_token_to_classname

c.TerminalInteractiveShell.true_color = True
c.TerminalInteractiveShell.highlighting_style = 'goodnight'
c.TerminalInteractiveShell.highlight_matching_brackets = False

# Fix completion highlighting as per https://github.com/ipython/ipython/issues/11526
# Copied from: https://github.com/petobens/dotfiles/blob/master/python/ipython_config.py
def my_style_from_pygments_dict(pygments_dict):
    """Monkey patch prompt toolkit style function to fix completion colors."""
    pygments_style = []
    for token, style in pygments_dict.items():
        if isinstance(token, str):
            pygments_style.append((token, style))
        else:
            pygments_style.append((pygments_token_to_classname(token), style))
    return Style(pygments_style)

prompt_toolkit.styles.pygments.style_from_pygments_dict = my_style_from_pygments_dict
IPython.terminal.interactiveshell.style_from_pygments_dict = my_style_from_pygments_dict

green = '#a7bd68'
red = '#cc6666'
term_fg = '#d0d0d0'
term_bg = '#171818'
selection_bg = '#313438'

c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: green,
    Token.PromptNum: green,
    Token.OutPrompt: red,
    Token.OutPromptNum: red,
    'completion-menu': f'bg:{selection_bg} {term_fg}',
    'completion-menu.completion.current': f'bg:{term_fg} {term_bg}',
    'completion-menu.completion': f'bg:{selection_bg} {term_fg}',
    'completion-menu.meta.completion.current': f'bg:{term_fg} {term_bg}',
    'completion-menu.meta.completion': f'bg:{selection_bg} {term_fg}',
    'completion-menu.multi-column-meta': f'bg:{selection_bg} {term_fg}'
}
