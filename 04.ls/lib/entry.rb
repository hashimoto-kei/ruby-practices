# frozen_string_literal: true

class Entry
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def hidden?
    @file_name.start_with?('.')
  end
end
