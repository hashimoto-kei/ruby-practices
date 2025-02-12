# frozen_string_literal: true

class LsFile
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def hidden?
    @name.start_with?('.')
  end
end
