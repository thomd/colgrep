#!/usr/bin/env bats

load test_helper

@test "colgrep should color a pattern within a string" {
  echo "foobarbaz" > test.txt
  run colgrep bar test.txt
  [ "$output" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
}
