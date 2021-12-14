# Pygment style backup from /usr/lib/python<version>/site-packages/pygments/styles/
# Used for IPython shell syntax highlighting colorscheme

from pygments.style import Style
from pygments.token import (
    Comment, Error, Keyword, Literal, Name, Number, Operator, String, Text
)


class GoodnightStyle(Style):
    background = '#171818'
    foreground = '#d0d0d0'

    red = '#cc6666'
    green = '#a7bd68'
    yellow = '#f0c674'
    blue = '#81a2be'
    magenta = '#b294bb'
    cyan = '#8abeb7'

    orange = '#de935f'
    brown = '#a3685a'
    bright_white = '#ffffff'

    light_bg = '#222525'
    selection_bg = '#313438'
    comment = '#5f6160'

    default_style = ''

    background_color = background
    highlight_color = selection_bg

    styles = {
        Text: foreground,
        Error: red,  # .err

        Comment: "italic " + comment,  # .c
        Comment.Preproc: brown,  # .cp
        Comment.PreprocFile: green,  # .cpf

        Keyword: magenta,  # .k
        Keyword.Type: red,  # .kt

        Name.Attribute: blue,  # .na
        Name.Builtin: blue,  # .nb
        Name.Builtin.Pseudo: red,  # .bp
        Name.Class: blue,  # .nc
        Name.Constant: orange,  # .no
        Name.Decorator: orange,  # .nd
        Name.Function: blue,  # .nf
        Name.Namespace: blue,  # .nn
        Name.Tag: magenta,  # .nt
        Name.Variable: blue,  # .nv
        Name.Variable.Instance: red,  # .vi

        Number: orange,  # .m

        Operator: foreground,  # .o
        Operator.Word: magenta,  # .ow

        Literal: green,  # .l

        String: green,  # .s
        String.Interpol: brown,  # .si
        String.Regex: cyan,  # .sr
        String.Symbol: orange,  # .ss
    }
