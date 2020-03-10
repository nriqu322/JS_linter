class ReadFile
  def get_file_data(path)
    file_data = File.read(path).split
    file_data
  end
end