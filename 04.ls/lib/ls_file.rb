# frozen_string_literal: true

require 'etc'

class LsFile
  FTYPE_TO_TYPE = {
    directory: 'd',
    file: '-',
    link: 'l',
  }.freeze

  def initialize(path)
    @path = path
  end

  def name = File.basename(@path)
  def type = FTYPE_TO_TYPE[stat.ftype.to_sym]
  def mode = symbolize_mode(stat.mode.to_s(8)[-3..])
  def hard_links = stat.nlink
  def owner_name = Etc.getpwuid(stat.uid).name
  def group_name = Etc.getgrgid(stat.gid).name
  def size = stat.size
  def timestamp = stat.mtime
  def link_name = symbolic_link? ? File.readlink(@path) : nil
  def blocks = stat.blocks

  def hidden?
    name.start_with?('.')
  end

  def symbolic_link?
    File.symlink?(@path)
  end

  private

  def stat = File.lstat(@path)

  def symbolize_mode(absolute_mode)
    absolute_mode
      .chars
      .map { |octal_permission| symbolize_octal_permission(octal_permission) }
      .join
  end

  def symbolize_octal_permission(octal_permission)
    octal_permission
      .to_i
      .to_s(2)
      .rjust(3, '0')
      .chars
      .map
      .with_index { |digit, index| digit == '1' ? 'rwx'[index] : '-' }
      .join
  end
end
