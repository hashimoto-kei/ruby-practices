# frozen_string_literal: true

require_relative 'ls_file'
require_relative 'formatter'
require_relative 'l_option_formatter'

class LsCommand
  def initialize(path, options)
    @path = File.expand_path(path || '.')
    @options = options
  end

  def execute
    ls_files = Dir.entries(@path).map { |entry| LsFile.new(File.join(@path, entry)) }
    filtered_ls_files = filter_ls_files(ls_files)
    sorted_ls_files = sort_ls_files(filtered_ls_files)
    puts formatter.format(sorted_ls_files)
  end

  private

  def filter_ls_files(ls_files)
    @options[:a] ? ls_files : ls_files.reject(&:hidden?)
  end

  def sort_ls_files(ls_files)
    sorted_ls_files = ls_files.sort_by(&:name)
    @options[:r] ? sorted_ls_files.reverse : sorted_ls_files
  end

  def formatter
    @options[:l] ? LOptionFormatter : Formatter
  end
end
