# colgrep(1) 

[![Build Status](https://travis-ci.org/thomd/colgrep.png)](https://travis-ci.org/thomd/colgrep)

A lightweigth colorizer for a stdin stream. Like grep, but prints all lines.

To always recognize what's important!

### Syntax

    colgrep [PATTERN [PATTERN ...]] [-c COLOR]

### Examples

Hightlight errors and warnings in a streaming error log

    tail -f error.log | colgrep error warn -c red

Highlight HTTP redirects

    curl -IL google.com | colgrep Location    

###  Installation

    make test
    make install
