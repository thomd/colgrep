# colgrep(1) - colorize a stdin stream

## SYNOPSIS

**colgrep** [**-h**] [**-c** COLOR] [**-b**] [**-l**] [**-i**] [**-v**] <*PATTERN*> [*PATTERN* ...]  

## DESCRIPTION

A lightweigth colorizer for a STDIN stream. Like grep, but prints all lines.

## OPTIONS
**-c**
    highlight color: blue, green (default), grey, red, yellow

**-b**
    colorize background

**-i**
    ignore case

**-v**
    invert match

**-l**
    colorize whole line

## EXAMPLES
Highlight current calendar date in cal(1):

      cal | colgrep $(date +%e) -c red

Highlight UDP request when using tcpdump(1):

      tcpdump | colgrep UDP

Highlight all HTTP redirects when requesting google.de:

      curl -sIL google.de | colgrep -bi location

Highlight all 404 requests in an apache access.log:

      tail -f /var/log/apache/access.log | colgrep " 404 " -c red

## AUTHOR
**Thomas Duerr** (thomduerr@gmail.com)

## GITHUB
http://github.com/thomd/colgrep
