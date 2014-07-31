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

    git clone --recursive git://github.com/malept/vimfiles
    cd vimfiles
    for f in vim vimrc gvimrc; do
        ln -s `pwd`/${f} ~/.${f}
    done

Partial installation is left as an exercise to the reader.

Bundles
-------

To see a comprehensive list of bundles, check out the ``vim/bundle`` directory.

Adding a new bundle
~~~~~~~~~~~~~~~~~~~

Use the ``add_bundle.sh`` script. Usage::

    ./add_bundle.sh [git URL]

Updating bundles
~~~~~~~~~~~~~~~~

You can update all of the bundles with ``update_bundles.sh``. Usage::

    ./update_bundles.sh

``vim-profile``
---------------

There is a way to load a subset of bundles by running Vim (or GVim, or
``view``) with ``vim-profile`` (or ``gvim-profile``, or ``view-profile``,
respectively). Usage::

    vim-profile [comma-separated profile names] [...additional Vim args...]

``vim-profile`` requires Python 2.7. It does not currently work with Python 3.

Creating a profile
~~~~~~~~~~~~~~~~~~

A profile folder is basically a vim folder where subfolders such as ``bundle``
and ``after``. Symlink everything that you want to include in the profile.

License
-------

Everything not in ``vim/bundle`` and ``special`` is licensed under the terms of
the LGPL 3 or later, unless otherwise noted. Please see ``LICENSE`` for details.
Alternative suggestions for a license are welcome.
