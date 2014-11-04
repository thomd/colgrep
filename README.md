# colgrep(1) 

[![Build Status](https://travis-ci.org/thomd/colgrep.png)](https://travis-ci.org/thomd/colgrep)

A lightweigth colorizer for a STDIN stream. Like grep, but prints all lines.

> To always recognize what's important!

### Syntax

    colgrep [-h] [-c COLOR] [-b] [-l] [-i] [-v] [--version] PATTERN [PATTERN ...]

See man page for options

    man colgrep

### Examples

#### Highlight errors and warnings in a streaming error log in red

    tail -f access.log | colgrep 404 401 -c red

<img src="https://raw.githubusercontent.com/thomd/colgrep/images/colgrep2.png">

#### Highlight HTTP redirects

    curl -sIL google.de | colgrep Location

<img src="https://raw.githubusercontent.com/thomd/colgrep/images/colgrep1.png">

###  Installation

    make test
    make install
