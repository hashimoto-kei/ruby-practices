# frozen_string_literal: true

require_relative 'ls_file'
require_relative 'formatter'

class LsCommand
  def initialize(path)
    @path = File.expand_path(path || '.')
  end

  def execute
    files = generate_files
    Formatter.format(files)
  end

  private

  def generate_files
    files = Dir.entries(@path).sort.map { |entry| LsFile.new(entry) }
    files.reject(&:hidden?)
  end
end
