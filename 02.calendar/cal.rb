#!/usr/bin/env ruby
require 'date'
require 'optparse'

class Calender
  def initialize(year, month)
    @year = year
    @month = month
  end

  def generate
    [generate_header, generate_body].join("\n")
  end

  def generate_header
    first_row = "      #{@month}月 #{@year}"
    second_row = "日 月 火 水 木 金 土"
    [first_row, second_row].join("\n")
  end

  def generate_body
    generate_blank + generate_days
  end

  def generate_blank
    first_day = Date.new(@year, @month, 1)
    blank_days = Array.new(first_day.wday, "   ")
    blank_days.join
  end

  def generate_days
    first_day = Date.new(@year, @month, 1)
    last_day = Date.new(@year, @month, -1)
    (first_day..last_day).map do |date|
      date.day.to_s.rjust(2) + (date.wday == 6 ? "\n" : " ")
    end.join
  end
end

option = {}
opt = OptionParser.new
opt.on('-m month') {|v| option[:m] = v}
opt.on('-y year') {|v| option[:y] = v}
opt.parse!(ARGV)

month = option[:m] ? option[:m].to_i : Date.today.month
year = option[:y] ? option[:y].to_i : Date.today.year

puts Calender.new(year, month).generate
