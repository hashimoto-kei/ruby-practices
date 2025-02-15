# frozen_string_literal: true

require_relative 'ls_file'
require_relative 'formatter'

class LsCommand
  def initialize(option, path)
    @option = option
    @path = File.expand_path(path || '.')
  end

  def execute
    ls_files = Dir.entries(@path).sort.map { |entry| LsFile.new(entry) }
    filtered_ls_files = filter_ls_files(ls_files)
    puts Formatter.format(filtered_ls_files)
  end

  private

  def filter_ls_files(ls_files)
    @option[:a] ? ls_files : ls_files.reject(&:hidden?)
  end
end
