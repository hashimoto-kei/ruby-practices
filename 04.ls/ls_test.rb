require 'minitest/autorun'
require_relative './ls'

class LsTest < Minitest::Test
  def test_ls
    assert_equal `ls -l`, `./ls.rb -l`
  end
end
