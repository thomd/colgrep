#!/usr/bin/env bats

load test_helper

@test "display the help message if colgep is called without an argument" {
  run colgrep
  [ $status -eq 2 ]
  [[ "${lines[0]}" =~ ^usage: ]]
}

@test "list all available colors in the help message for the color option" {
  run colgrep -h
  [ $status -eq 0 ]
  [ "$(echo "$output" | grep -- 'blue, green (default), grey, red, yellow')" ]
}

@test "color a pattern within a string from STDIN with the default color" {
  echo "foobarbaz" | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "color a pattern within a string from STDIN with a specific color" {
  echo "foobarbaz" | {
    run colgrep bar -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;31mbar\033[0mbaz"` ]
  }
}

@test "color a pattern within a string from STDIN with the default color if the given color does not exist" {
  echo "foobarbaz" | {
    run colgrep bar -c foo
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "color multiple patterns within a string from STDIN" {
  echo "foobarfoobaz" | {
    run colgrep bar baz
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;32mbaz\033[0m"` ]
  }
}

@test "color a regular expression pattern within a string from STDIN" {
  echo "foo[200]bar[404]foo" | {
    run colgrep "\[\d+\]"
	[ $status -eq 0 ]
	[ "${lines[0]}" == `echo -e "foo\033[0;32m[200]\033[0mbar\033[0;32m[404]\033[0mfoo"` ]
  }
}

@test "color patterns in a string from STDIN with different colors" {
  echo "foobarfoobaz" | colgrep bar | {
    run colgrep baz -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;31mbaz\033[0m"` ]
  }
}

