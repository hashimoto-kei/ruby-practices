# frozen_string_literal: true

require 'minitest/autorun'

class WcTest < Minitest::Test
  def test_wc
    assert_equal `wc fileA`, `./wc.rb fileA`
    assert_equal `wc fileA fileB`, `./wc.rb fileA fileB`
  end
end
