require 'colorize'

class JsParse
  def initialize(arr)
    @arr = arr
    @open_brace = 0
    @close_brace = 0
  end

  def lowercase_names(line, line_num)
    if /^[A-Z]/.match(line)
      puts 'WARNING:'.yellow + "line #{line_num}, camelCase is recommended for identifier names (variables and functions)."
    elsif /_/.match(line)
      puts 'WARNING:'.yellow + "line #{line_num}, camelCase is recommended for identifier names (variables and functions), avoid underscore."
    end
  end

  def end_semicolon(line)
    if .match(line)
  end

  def space_before_braces(line, line_num)
    if /\S\{/.match(line)
      puts 'ERROR:'.red + "line #{line_num}, missing space before open brace"
    end
  end

  def check_braces
    diff = @open_brace - @close_brace
    if diff < 0
      puts "ERROR: ".red + "Number of missing open braces : #{diff}"
    elsif diff > 0
      puts "ERROR: ".red + "Number of missing closed braces : #{diff}"
    end
  end

  def spaces_around(line, line_num)
    if /\S\+|\+\S|\S\-|\-\S|\S\*|\*\S|\S\=|\=\S|\S\/|\/\S/ =~ line
      puts 'ERROR: '.red + "line #{line_num}, expected spaces around operator" unless /\=\=\=|\=\=/ =~ line 
    end
  end

  def find_pair_braces?(line, line_num)
    @open_brace +=1 if /\{/ =~ line
    @close_brace += 1 if  /\}/ =~ line
  end

  def pass_lines
    i = 0
    for i in (0..@arr.size) do
      line = @arr[i]
      spaces_around(line, i + 1)
      lowercase_names(line, i + 1)
      space_before_braces(line, i + 1)
      find_pair_braces?(line, i + 1)
    end
    check_braces
  end
end