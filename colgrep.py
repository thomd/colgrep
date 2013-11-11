#!/usr/bin/env python
import sys
import re

def colgrep(pattern):
	'''
	colorize pattern
	'''
	pre = re.compile("(" + pattern + ")")
	for line in sys.stdin.readlines():
		newline = pre.sub("\033[0;31m\g<1>\033[0m", line)
		sys.stdout.write(newline)

def main():
	if len(sys.argv) == 2:
		pattern = sys.argv[1]
		colgrep(pattern)
	else:
		print "argument required"
		sys.exit(1)

if __name__ == '__main__':
	main()
