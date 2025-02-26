# frozen_string_literal: true

class LOptionFormatter
  class << self
    def format(ls_files)
      header = generate_header(ls_files)
      body = generate_body(ls_files)
      [header, *body].join("\n")
    end

    private

    def generate_header(ls_files)
      total = ls_files.map(&:blocks).sum
      "total #{total}"
    end

    def generate_body(ls_files)
      now = Time.now
      max_widths = calculate_max_widths(ls_files, now)
      ls_files.map do |ls_file|
        formatted_file_name = format_file_name(ls_file.name, ls_file.link_name)
        "#{ls_file.type}#{ls_file.mode}" \
        "  #{ls_file.hard_links.to_s.rjust(max_widths[:hard_links])}" \
        " #{ls_file.owner_name.ljust(max_widths[:owner_name])}" \
        "  #{ls_file.group_name.ljust(max_widths[:group_name])}" \
        "  #{ls_file.size.to_s.rjust(max_widths[:size])}" \
        " #{ls_file.timestamp.strftime('%_m %_d %H:%M')}" \
        " #{formatted_file_name}"
      end
    end

    def calculate_max_widths(ls_files, now)
      max_widths = Hash.new(0)
      ls_files.each do |ls_file|
        widths = {
          hard_links: ls_file.hard_links.to_s.length,
          owner_name: ls_file.owner_name.length,
          group_name: ls_file.group_name.length,
          size: ls_file.size.to_s.length,
        }
        widths.each_key { |key| max_widths[key] = widths[key] if max_widths[key] < widths[key] }
      end
      max_widths
    end

    def format_file_name(file_name, link_name)
      link_name.nil? ? file_name : "#{file_name} -> #{link_name}"
    end
  end
end
