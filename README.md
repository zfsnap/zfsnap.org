# zfsnap website

[![Travis tests status](https://secure.travis-ci.org/zfsnap/zfsnap.org.png?branch=master)](https://travis-ci.org/zfsnap/zfsnap.org)

This is the repository to generate the zfsnap website. The code and docs are
kept in the "site-code" branch. The html generated is copied and committed to
the master branch. Any static content in the master branch is graciously hosted
by GitHub Pages.

Documentation is written as HTML fragments and are `cat`ed into the rest of the
page's HTML.

Patches are always welcome.

# How to use

Pages are located in the "content/" folder and should be named
<page_name>.fragment.

Everything in "static/" is copied directly to the generated site.

See `make help` for available building options.

To `make publish`, be sure to have both the "master" and "site-code" branches
checked out. 

# Building the manpage HTML

`make manpage` (which converts the manpage to HTML) requires `mandoc`. As far
as I am aware, `mandoc` is only available on BSD systems. It would be nice to
use a more common/portable solution, but `groff`'s output is truly terrible.
`mandoc` was the only way I could generate legible output.

The manpage in this repository is a symlink to ../zfsnap/man/man8/zfsnap.8
It's suboptimal, but I found it to be better than including the entire zfsnap
repo as a submodule.

