class ReadFile
  def get_file_data(path)
    file = File.open(path)
    content = file.readlines.map(&:chomp)
    file.close
    content
  end
end
