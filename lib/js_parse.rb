require 'colorize'
# rubocop : disable Style/GuardClause

class JsParse
  def initialize(arr)
    @arr = arr
    @open_brace = 0
    @close_brace = 0
  end

  def lowercase_names(line, line_num)
    if /^[A-Z]/.match(line)
      puts 'WARNING: '.yellow + "line #{line_num}, camelCase is recommended for identifier names."
      true
    end
  end

  def underscore_names(line, line_num)
    if /_/.match(line)
      puts 'WARNING: '.yellow + "line #{line_num}, avoid underscore in names, use camelCase."
      true
    end
  end

  def end_semicolon(line, line_num)
    if /^[^\n|\}|function](?:(?!;).)*$/.match(line)
      puts 'ERROR: '.red + "line #{line_num}, missing semicolon at the end of line"
      true
    end
  end

  def space_before_braces(line, line_num)
    if /\S\{/.match(line)
      puts 'ERROR: '.red + "line #{line_num}, missing space before open brace."
      true
    end
  end

  def space_in_line(line, line_num)
    if /[\w]\s\s/.match(line)
      puts 'ERROR: '.red + "line #{line_num}, check for double spaces."
      true
    end
  end

  def space_end_line(line, line_num)
    if /\s$/.match(line)
      puts 'ERROR: '.red + "line #{line_num}, remove spaces at the end of the line."
      true
    end
  end

  def check_braces
    diff = @open_brace - @close_brace
    if diff.negative?
      puts 'ERROR: '.red + "Number of missing open braces : #{diff}."
      true
    elsif diff.psitive?
      puts 'ERROR: '.red + "Number of missing close braces : #{diff}."
      true
    end
  end

  def spaces_around(line, line_num)
    if %r{\S\+|\+\S|\S\-|\-\S|\S\*|\*\S|\S\=|\=\S|\S/|/\S} =~ line
      puts 'ERROR: '.red + "line #{line_num}, expected spaces around operator." unless /\=\=\=|\=\=/ =~ line
      true
    end
  end

  def count_pair_braces(line)
    @open_brace += 1 if /\{/ =~ line
    @close_brace += 1 if /\}/ =~ line
  end

  def pass_lines
    (0..@arr.size).each do |i|
      line = @arr[i]
      spaces_around(line, i + 1)
      lowercase_names(line, i + 1)
      underscore_names(line, i + 1)
      space_before_braces(line, i + 1)
      count_pair_braces(line)
      space_end_line(line, i + 1)
      space_in_line(line, i + 1)
      end_semicolon(line, i + 1)
    end
    check_braces
  end
end
# rubocop : enable Style/GuardClause
