#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'etc'

class Entry
  attr_reader :file_name, :file_type, :permissions, :nlink, :user_name, :group_name, :size, :timestamp, :blocks, :symbolic_link

  def initialize(path='', long_format=false)
    @file_name = File.basename(path)
    if long_format
      stat = File.lstat(path)
      @file_type = to_file_type(stat.ftype)
      mode = stat.mode.to_s(8).rjust(6, '0')
      @permissions = to_permissions(mode[-3..-1])
      @nlink = stat.nlink
      @user_name = Etc.getpwuid(stat.uid).name
      @group_name = Etc.getgrgid(stat.gid).name
      @size = stat.size
      @timestamp = to_timestamp(stat.mtime)
      @blocks = stat.blocks
      @symbolic_link = " -> #{File.readlink(path)}" if @file_type == 'l'
    end
  end

  private

  def to_permissions(octats)
    permissions = octats.chars.map { |octat| to_permission(octat) }
    permissions.join
  end

  def to_permission(octat)
    permissions = octat.to_i.to_s(2).chars.map.with_index do |digit, i|
      case i
      when 0
        digit == '1' ? 'r' : '-'
      when 1
        digit == '1' ? 'w' : '-'
      when 2
        digit == '1' ? 'x' : '-'
      end
    end
    permissions.join
  end

  def to_file_type(ftype)
    case ftype
    when 'fifo'
      'p'
    when 'characterSpecial'
      'c'
    when 'directory'
      'd'
    when 'blockSpecial'
      'b'
    when 'file'
      '-'
    when 'link'
      'l'
    when 'socket'
      's'
    end
  end

  def to_timestamp(mtime)
    mtime.to_s.gsub(/(\d{4})-(\d)(\d)-(\d)(\d) (\d{2}:\d{2}).*/) do
      month = ($2 == '0' ? " #{$3}" : "#{$2}#{$3}")
      day = ($4 == '0' ? " #{$5}" : "#{$4}#{$5}")
      if $1 == Date.today.year.to_s
        "#{month} #{day} #{$6}"
      else
        "#{month} #{day} #{$1}"
      end
    end
  end
end
