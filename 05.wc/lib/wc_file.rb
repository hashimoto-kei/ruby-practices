# frozen_string_literal: true

class WcFile
  attr_reader :path

  def initialize(path)
    @path = path
    $stdin = File.open(path) unless path.nil?
    @lines = $stdin.readlines
  end

  def count_lines = @lines.size
  def count_words = @lines.sum { |line| line.split(/\s+/).size }
  def count_characters = @lines.sum(&:size)
end
