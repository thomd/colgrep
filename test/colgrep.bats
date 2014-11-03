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

@test "color a pattern with the default color" {
  echo "foobarbaz" | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "color a pattern with a specific color" {
  echo "foobarbaz" | {
    run colgrep bar -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;31mbar\033[0mbaz"` ]
  }
}

@test "color a pattern with the default color if the given color does not exist" {
  echo "foobarbaz" | {
    run colgrep bar -c foo
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "color multiple patterns" {
  echo "foobarfoobaz" | {
    run colgrep bar baz
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;32mbaz\033[0m"` ]
  }
}

@test "color multiple patterns using multiple pipes" {
  echo "foobarfoobaz" | colgrep bar | {
    run colgrep baz
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;32mbaz\033[0m"` ]
  }
}

@test "color a pattern using a regular expression" {
  echo "foo[200]bar[404]foo" | {
    run colgrep "\[\d+\]"
	[ $status -eq 0 ]
	[ "${lines[0]}" == `echo -e "foo\033[0;32m[200]\033[0mbar\033[0;32m[404]\033[0mfoo"` ]
  }
}

@test "color multiple patterns with different colors" {
  echo "foobarfoobaz" | colgrep bar | {
    run colgrep baz -c red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mfoo\033[0;31mbaz\033[0m"` ]
  }
}

@test "color pattern ignoring case using the -i option" {
  echo "foobAr" | {
    run colgrep -i bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbAr\033[0m"` ]
  }
}

@test "do not color pattern ignoring case if -i option is missing" {
  echo "foobAr" | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foobAr"` ]
  }
}

@test "color invert pattern using the -v option" {
  echo "aaafoobarfoobazaaa" | {
    run colgrep -v foo
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "\033[0;32maaa\033[0mfoo\033[0;32mbar\033[0mfoo\033[0;32mbazaaa"` ]
  }
}

@test "color a pattern with a specific background color" {
  echo "foobarbaz" | {
    run colgrep bar -bc red
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;30;41mbar\033[0mbaz"` ]
  }
}

@test "color a pattern using tail(1)" {
  echo "foobarbaz" > test.txt
  tail test.txt | {
    run colgrep bar
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "foo\033[0;32mbar\033[0mbaz"` ]
  }
}

@test "color whole line on match" {
  echo "foobarbaz" | {
    run colgrep -l bar
    echo "out: $status"
    [ $status -eq 0 ]
    [ "${lines[0]}" == `echo -e "\033[0;32mfoobarbaz\033[0m"` ]
  }
}

