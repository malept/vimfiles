= Vim Configuration =

This is Mark's Vim configuration. He's put it up here so that he can have
a place to easily install it for whatever computer he's running Vim on.

If you're not Mark, you may want to look over the files to see what
*exactly* is going on before installing it, instead of blindly copying and
pasting into your local config (which is never a good idea to begin with).

This particular configuration attempts to emphasize the using Vim keybindings,
as opposed to emulating other editors' keybindings.

== Installation ==

To install everything, run the following commands::

    git clone git://github.com/malept/vimfiles
    for f in vim vimrc gvimrc; do
        ln -s `pwd`/${f} ~/.${f}
    done

Partial installation is left as an exercise to the reader.

== Bundled Plugins ==

**TODO**

== License ==

Everything not in ``vim/bundle`` is licensed under the terms of the LGPL 3
or later, unless otherwise noted. Please see ``LICENSE`` for details.
Alternative suggestions for a license are welcome.
