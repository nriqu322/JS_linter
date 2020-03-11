#!/usr/bin/env ruby
require_relative '../lib/read_file.rb'
require_relative '../lib/js_parse.rb'

file_data = ReadFile.new.get_file_data('./assets/test_read_file.js')
js_parse = JsParse.new(file_data)
js_parse.pass_lines