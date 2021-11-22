Vim Configuration
=================

This is Mark's Vim configuration. He's put it up here so that he can have
a place to easily install it for whatever computer he's running Vim on.

If you're not Mark, you may want to look over the files to see what
*exactly* is going on before installing it, instead of blindly copying and
pasting into your local config (which is never a good idea to begin with).

This particular configuration attempts to emphasize using Vim's keybindings,
as opposed to emulating other editors' keybindings.

Installation
------------

To install everything, run the following commands::

    git clone https://github.com/malept/vimfiles
    cd vimfiles
    mkdir -p ~/.config/nvim
    ln -s `pwd`/init.lua ~/.config/nvim/

Partial installation is left as an exercise to the reader.

License
-------

This repository is licensed under the terms of the LGPL 3 or later, unless otherwise noted. Please
see ``LICENSE`` for details. Alternative suggestions for a license are welcome.
