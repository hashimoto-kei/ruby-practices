# frozen_string_literal: true

require_relative 'ls_file'
require_relative 'formatter'

class LsCommand
  def initialize(path)
    @path = File.expand_path(path || '.')
  end

  def execute
    ls_files = Dir.entries(@path).sort.map { |entry| LsFile.new(entry) }.reject(&:hidden?)
    puts Formatter.format(ls_files)
  end
end
