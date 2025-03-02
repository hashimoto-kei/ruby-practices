# frozen_string_literal: true

class Formatter
  WIDTH = 7

  class << self
    def format(wc_files, options)
      total_counts = Hash.new(0)
      body = wc_files.map do |wc_file|
        counts = {
          lines: wc_file.count_lines,
          words: wc_file.count_words,
          characters: wc_file.count_characters
        }
        counts.each_key { |key| total_counts[key] += counts[key] }
        generate_row(counts, wc_file.path, options)
      end
      footer = generate_row(total_counts, 'total', options) if wc_files.size > 1
      [*body, footer].join("\n")
    end

    private

    def generate_row(counts, file_path, options)
      no_options = options.values.none?
      cols = []
      cols << counts[:lines].to_s.rjust(WIDTH) if no_options || options[:l]
      cols << counts[:words].to_s.rjust(WIDTH) if no_options || options[:w]
      cols << counts[:characters].to_s.rjust(WIDTH) if no_options || options[:c]
      cols << file_path
      ' ' + cols.join(' ')
    end
  end
end
