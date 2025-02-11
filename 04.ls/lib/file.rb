# frozen_string_literal: true

module LS
end

class LS::File
  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def hidden?
    @file_name.start_with?('.')
  end
end
