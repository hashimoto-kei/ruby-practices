# frozen_string_literal: true

require_relative 'wc_file'
require_relative 'formatter'

class WcCommand
  def initialize(paths, options)
    @paths = paths
    @options = options
  end

  def execute
    puts Formatter.format(wc_files, @options)
  end

  private

  def wc_files
    @paths.empty? ? [WcFile.new] : @paths.map { |path| WcFile.new(path) }
  end
end
