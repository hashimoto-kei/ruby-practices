# frozen_string_literal: true

require_relative 'wc_file'
require_relative 'formatter'

class WcCommand
  def initialize(paths, options)
    @paths = paths
    @options = options
  end

  def execute
    wc_files = @paths.map { |path| WcFile.new(path) }
    puts Formatter.format(wc_files, @options)
  end
end
