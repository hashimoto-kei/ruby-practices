# frozen_string_literal: true

module LS
end

class LS::File
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hidden?
    @name.start_with?('.')
  end
end
