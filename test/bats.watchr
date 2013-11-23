def run_test
  system("clear")
  system("bats test")
end
watch("colgrep.*"){ run_test }
watch("test/test_helper.bash"){ run_test }
watch("test/*.\.bats"){ run_test }
run_test
# vim:ft=ruby
