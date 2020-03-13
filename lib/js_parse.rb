require 'colorize'

class JsParse
  attr_reader :arr

  def initialize(arr)
    @arr = arr
    @open_brace = 0
    @close_brace = 0
  end

  def lowercase_names?(line, line_num)
    return false unless /^[A-Z]/.match(line)

    puts 'WARNING: '.yellow + "line #{line_num}, camelCase is recommended for identifier names." if /^[A-Z]/.match(line)
    true
  end

  def underscore_names?(line, line_num)
    return false unless /_/.match(line)

    puts 'WARNING: '.yellow + "line #{line_num}, avoid underscore in names, use camelCase."
    true
  end

  def missing_semicolon?(line, line_num)
    return false unless /^[^\n|\}|function](?:(?!;).)*$/.match(line)

    puts 'ERROR: '.red + "line #{line_num}, missing semicolon at the end of line."
    true
  end

  def space_before_braces?(line, line_num)
    return false unless /\S\{/.match(line)

    puts 'ERROR: '.red + "line #{line_num}, missing space before open brace."
    true
  end

  def space_in_line?(line, line_num)
    return false unless /.+[\w]\s\s.+/.match(line)

    puts 'ERROR: '.red + "line #{line_num}, check for double spaces."
    true
  end

  def space_end_line?(line, line_num)
    return false unless /\s$/.match(line)

    puts 'ERROR: '.red + "line #{line_num}, remove spaces at the end of the line."
    true
  end

  def check_braces
    diff = (@open_brace - @close_brace).abs
    if diff.negative?
      puts 'ERROR: '.red + "Number of missing open braces : #{diff}."
    elsif diff.positive?
      puts 'ERROR: '.red + "Number of missing close braces : #{diff}."
    end
    true
  end

  def spaces_around?(line, line_num)
    return false unless %r{\S\+|\+\S|\S\-|\-\S|\S\*|\*\S|\S\=|\=\S|\S/|/\S} =~ line

    puts 'ERROR: '.red + "line #{line_num}, expected spaces around operator." unless /\=\=\=|\=\=/ =~ line
    true
  end

  private

  def count_pair_braces(line)
    @open_brace += 1 if /\{/ =~ line
    @close_brace += 1 if /\}/ =~ line
  end

  public

  def pass_lines
    (0..arr.size).each do |i|
      line = arr[i]
      spaces_around?(line, i + 1)
      lowercase_names?(line, i + 1)
      underscore_names?(line, i + 1)
      space_before_braces?(line, i + 1)
      count_pair_braces(line)
      space_end_line?(line, i + 1)
      space_in_line?(line, i + 1)
      missing_semicolon?(line, i + 1)
    end
    check_braces
  end
end
