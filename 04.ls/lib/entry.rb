# frozen_string_literal: true

class Entry
  attr_reader :file_name

  def initialize(path)
    @file_name = File.basename(path)
  end

  def hidden?
    @file_name.start_with?('.')
  end
end
