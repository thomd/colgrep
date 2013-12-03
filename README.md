# colgrep(1) 

[![Build Status](https://travis-ci.org/thomd/colgrep.png)](https://travis-ci.org/thomd/colgrep)

A lightweigth colorizer for STDOUT like grep but prints all lines.

To always recognize what's important!

### Syntax

    colgrep <pattern> [color] [file]

### Examples

    colgrep 127.0.0.1 access.log                      # highlight requests from localhost

    tail -f error.log | colgrep error

    curl -I google.com | colgrep Location             # highlight HTTP redirects

###  Installation

    make test
    make install
