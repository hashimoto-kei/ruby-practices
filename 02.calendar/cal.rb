#!/usr/bin/env ruby
require 'date'
require 'optparse'

class Calendar
  def initialize(year, month)
    @year = year ? year.to_i : Date.today.year
    @month = month ? month.to_i : Date.today.month
    @first_date = Date.new(@year, @month, 1)
  end

  def generate
    [*generate_header, generate_body].join("\n")
  end

  private

  def generate_header
    first_row = "      #{@month}月 #{@year}"
    second_row = "日 月 火 水 木 金 土"
    [first_row, second_row]
  end

  def generate_body
    generate_blank + generate_days
  end

  def generate_blank
    blank_days = Array.new(@first_date.wday, "   ")
    blank_days.join
  end

  def generate_days
    last_date = Date.new(@year, @month, -1)
    (@first_date..last_date).map do |date|
      date.day.to_s.rjust(2) + (date.saturday? ? "\n" : " ")
    end.join
  end
end

option = {}
opt = OptionParser.new
opt.on('-m month') {|v| option[:m] = v}
opt.on('-y year') {|v| option[:y] = v}
opt.parse!(ARGV)

puts Calendar.new(option[:y], option[:m]).generate
