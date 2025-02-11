# frozen_string_literal: true

require_relative 'file'
require_relative 'formatter'

class LsCommand
  def initialize(path)
    @path = File.expand_path(path || '.')
  end

  def execute
    entries = generate_entries
    Formatter.format(entries)
  end

  private

  def generate_entries
    entries = Dir.entries(@path).sort.map { |entry| LS::File.new(entry) }
    entries.reject(&:hidden?)
  end
end
