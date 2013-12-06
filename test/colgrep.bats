#!/usr/bin/env bats

load test_helper

@test "colgrep should color a pattern within a piped string with the default color" {
  echo "foobarbaz" | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "colgrep should color a pattern within a piped string with a specific color" {
  echo "foobarbaz" | {
    run colgrep bar -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;31mbar\033[0mbaz"` ]
  }
}

@test "colgrep should color multiple pattern within a piped string" {
  echo "foobarfoobaz" | {
    run colgrep bar baz
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;32mbaz\033[0m"` ]
  }
}
