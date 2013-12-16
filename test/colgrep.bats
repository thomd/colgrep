#!/usr/bin/env bats

load test_helper

@test "colgrep should color a pattern within a string with the default color" {
  echo "foobarbaz" | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "colgrep should color a pattern within a string with a specific color" {
  echo "foobarbaz" | {
    run colgrep bar -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;31mbar\033[0mbaz"` ]
  }
}

@test "colgrep should color multiple pattern within a string" {
  echo "foobarfoobaz" | {
    run colgrep bar baz
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;32mbaz\033[0m"` ]
  }
}

@test "colgrep should color a regular expression pattern" {
  echo "foo[200]bar[404]foo" | {
    run colgrep "\[\d+\]"
	[ $status -eq 0 ]
	[ "${lines[0]}" == `echo -e "foo\033[0;32m[200]\033[0mbar\033[0;32m[404]\033[0mfoo"` ]
  }
}

@test "colgrep should color patterns with individual colors" {
  echo "foobarfoobaz" | colgrep bar | {
    run colgrep baz -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;31mbaz\033[0m"` ]
  }
}



