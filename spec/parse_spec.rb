require_relative '../lib/read_file.rb'
require_relative '../lib/js_parse.rb'

RSpec.describe JsParse do
  # rubocop : disable Style/BlockDelimiters
  let(:file_data) {
    %(
FirstName = 'John';
last_Name = 'Doe';

fullName = firstName+ lastName;

var x = 5, y = 7;
console.log\(x + y\);

function isEven\(num\)\{
  return  num % 2 == 0;


function sum\(x, y\) \{
  return x + y
\}
    )
  }
  # rubocop : enable Style/BlockDelimiters

  let(:js_parse) { JsParse.new(file_data) }

  describe '#lowercase_names?' do
    it 'check if names indentifier starts with capital letter' do
      expect(js_parse.lowercase_names?(file_data, 1)).to eql(true)
    end
  end

  describe '#underscore_names?' do
    it 'check if names indetifier has an underscore' do
      expect(js_parse.underscore_names?(file_data, 2)).to eql(true)
    end
  end

  describe '#missing_semicolon?' do
    it 'check if and statement end with a semicolon' do
      expect(js_parse.missing_semicolon?(file_data, 14)).to eql(true)
    end
  end

  describe '#space_before_braces?' do
    let(:my_method) do
      proc do
        js_parse.space_before_braces?(file_data, 9)
      end
    end

    it 'check if there is a space before a brace' do
      expect(my_method.call).to eql(true)
    end
  end

  describe '#space_end_line?' do
    let(:my_method) do
      proc do
        js_parse.space_end_line?(file_data, 4)
      end
    end

    it 'check if there is space at the end of a line' do
      expect(my_method.call).to eql(true)
    end
  end

  describe '#space_in_line?' do
    let(:my_method) do
      proc do
        js_parse.space_in_line?(file_data, 10)
      end
    end

    it 'check if there is double space in a line' do
      expect(my_method.call).to eql(true)
    end
  end

  describe '#spaces_around?' do
    let(:my_method) do
      proc do
        js_parse.spaces_around?(file_data, 4)
      end
    end

    it 'check if there is an space before and after an operator' do
      expect(my_method.call).to eql(true)
    end
  end

  describe '#check_braces' do
    let(:my_method) do
      proc do
        js_parse.check_braces
      end
    end

    it 'check if there is a missing openning or closing brace' do
      expect(my_method.call).to eql(true)
    end
  end
end
