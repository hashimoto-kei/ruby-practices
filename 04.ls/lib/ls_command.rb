# frozen_string_literal: true

require_relative 'entry'
require_relative 'formatter'

class LsCommand
  def initialize(path)
    path ||= '.'
    @path = File.expand_path(path)
  end

  def generate
    entries = generate_entries
    Formatter.format(entries)
  end

  def generate_entries
    entries = Dir.entries(@path).sort.map { |entry| Entry.new("#{@path}/#{entry}") }
    entries.reject(&:hidden?)
  end
end
