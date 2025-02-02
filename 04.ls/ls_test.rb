require 'minitest/autorun'
require_relative './ls'

class LsTest < Minitest::Test
  def test_ls
    assert_equal `ls -l`, `./ls.rb -l`
    assert_equal `ls -l ~/workspace/design-pattern-multi-thread-1st`, `./ls.rb -l ~/workspace/design-pattern-multi-thread-1st`
    assert_equal `ls -al`, `./ls.rb -al`
    assert_equal `ls -rl`, `./ls.rb -rl`
    assert_equal `ls -arl`, `./ls.rb -arl`
  end
end
