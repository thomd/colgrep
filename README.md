# colgrep(1) 

[![Build Status](https://travis-ci.org/thomd/colgrep.png)](https://travis-ci.org/thomd/colgrep)

A lightweigth colorizer for a STDIN stream. Like grep, but prints all lines.

> To always recognize what's important!

### Syntax

    colgrep [-h] [-c COLOR] [-b] [-l] [-i] [-v] [--version] PATTERN [PATTERN ...]

See man page for options

    man colgrep

### Examples

Hightlight errors and warnings in a streaming error log in red

    tail -f error.log | colgrep error warn -c red

Highlight HTTP redirects

    curl -sIL google.com | colgrep Location

###  Installation

    make test
    make install
