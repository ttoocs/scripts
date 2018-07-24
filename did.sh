#!/bin/bash
#urxvt.sh -e vim "+'normal Go' +'r!date'" ~/notes.tex
#urxvt.sh -e [[ "vim +'normal Go' +'r!date' ~/notes.tex" ]]

urxvt.sh -e vim +":r!date" ~/did.tex
