# frozen_string_literal: true

class WcFile
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def count_lines = lines.size
  def count_words = lines.sum { |line| line.split(/\s+/).size }
  def count_characters = lines.sum(&:size)

  private

  def lines
    return @lines if @lines
    File.open(@path) { |file| @lines = File.readlines(file) }
  end
end
