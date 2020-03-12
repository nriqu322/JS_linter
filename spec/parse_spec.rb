require_relative '../lib/read_file.rb'
require_relative '../lib/js_parse.rb'

RSpec.describe JsParse do
  let(:file_data) { "ReadFile.new.get_file_data('./assets/test_read_file.js')" }
  let(:js_parse) { JsParse.new(file_data) }

  describe '#lowercase_names' do
    it 'check if names indentifier starts with capital letter' do
      expect(js_parse.lowercase_names(file_data, 1)).to eql(true)
    end
  end

  describe '#underscore_names' do
    it 'check if names indetifier has an underscore' do
      expect(js_parse.underscore_names(file_data, 2)).to eql(true)
    end
  end

  describe '#end_semicolon' do
    it 'check if and statement end with a semicolon' do
      expect(js_parse.end_semicolon(file_data, 7)).to eql(true)
    end
  end

  describe '#space_before_braces' do
    it 'check if there is a space before a brace' do
      expect(js_parse.space_before_braces(file_data, 9)).to eql(true)
    end
  end

  describe '#space_end_line' do
    it 'check if there is space at the end of a line' do
      expect(js_parse.space_end_line(file_data, 4)).to eql(true)
    end
  end

  describe '#space_in_line' do
    it 'check if there is double space in a line' do
      expect(js_parse.space_in_line(file_data, 7)).to eql(true)
    end
  end

  describe '#check_braces' do
    it 'check if there is a missing openning or closing brace' do
      expect(js_parse.check_braces).to eql(true)
    end
  end

  describe '#spaces_around' do
    it 'check if there is an space before and after an operator' do
      expect(js_parse.spaces_around(file_data, 4)).to eql(true)
    end
  end
end
