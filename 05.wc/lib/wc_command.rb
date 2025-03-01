# frozen_string_literal: true

require_relative 'wc_file'
require_relative 'formatter'

class WcCommand
  def initialize(paths)
    @paths = paths
  end

  def execute
    wc_files = @paths.map { |path| WcFile.new(path) }
    puts Formatter.format(wc_files)
  end
end
