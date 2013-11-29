#!/usr/bin/env bats

load test_helper

@test "colgrep should color a pattern within a piped string" {
  echo "foobarbaz" | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}
