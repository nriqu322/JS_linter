class ReadFile
  def get_file_data(path)
    #line_num = 0
    #array = []
    #File.foreach(path) { |line| array << "#{line}" } 

    #file_data = File.read(path).split
    #file_data

    file = File.open(path)
    content = file.readlines.map(&:chomp)
    file.close
    content
  end
end
