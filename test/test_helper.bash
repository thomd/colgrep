export PATH=$(pwd):$PATH
export BATS_TEST_TMPDIR=$BATS_TMPDIR/tmp

setup() {
  [ ! -d $BATS_TEST_TMPDIR ] && mkdir $BATS_TEST_TMPDIR
  cd $BATS_TEST_TMPDIR
}

teardown() {
  rm -r $BATS_TEST_TMPDIR
}
