# frozen_string_literal: true

class WcFile
  attr_reader :path

  def initialize(path = nil)
    @path = path
    input = (path.nil? ? $stdin : File.open(path))
    @lines = input.readlines
  end

  def count_lines = @lines.size
  def count_words = @lines.sum { |line| line.split(/\s+/).size }
  def count_characters = @lines.sum(&:size)
end
