# frozen_string_literal: true

require 'minitest/autorun'

class WcTest < Minitest::Test
  def test_wc_one_file
    assert_equal `wc fileA`, `./wc.rb fileA`
    assert_equal `wc -l fileA`, `./wc.rb -l fileA`
    assert_equal `wc -w fileA`, `./wc.rb -w fileA`
    assert_equal `wc -c fileA`, `./wc.rb -c fileA`
    assert_equal `wc -lw fileA`, `./wc.rb -lw fileA`
    assert_equal `wc -wc fileA`, `./wc.rb -wc fileA`
    assert_equal `wc -cl fileA`, `./wc.rb -cl fileA`
    assert_equal `wc -lwc fileA`, `./wc.rb -lwc fileA`
  end

  def test_wc_two_files
    assert_equal `wc fileA fileB`, `./wc.rb fileA fileB`
    assert_equal `wc -l fileA fileB`, `./wc.rb -l fileA fileB`
    assert_equal `wc -w fileA fileB`, `./wc.rb -w fileA fileB`
    assert_equal `wc -c fileA fileB`, `./wc.rb -c fileA fileB`
    assert_equal `wc -lw fileA fileB`, `./wc.rb -lw fileA fileB`
    assert_equal `wc -wc fileA fileB`, `./wc.rb -wc fileA fileB`
    assert_equal `wc -cl fileA fileB`, `./wc.rb -cl fileA fileB`
    assert_equal `wc -lwc fileA fileB`, `./wc.rb -lwc fileA fileB`
  end

  def test_wc_stdin
    assert_equal `ls -l | wc `, `../04.ls/ls.rb -l | ./wc.rb`
    assert_equal `ls -l | wc -l`, `../04.ls/ls.rb -l | ./wc.rb -l`
    assert_equal `ls -l | wc -w`, `../04.ls/ls.rb -l | ./wc.rb -w`
    assert_equal `ls -l | wc -c`, `../04.ls/ls.rb -l | ./wc.rb -c`
    assert_equal `ls -l | wc -lw`, `../04.ls/ls.rb -l | ./wc.rb -lw`
    assert_equal `ls -l | wc -wc`, `../04.ls/ls.rb -l | ./wc.rb -wc`
    assert_equal `ls -l | wc -cl`, `../04.ls/ls.rb -l | ./wc.rb -cl`
    assert_equal `ls -l | wc -lwc`, `../04.ls/ls.rb -l | ./wc.rb -lwc`
  end
end
