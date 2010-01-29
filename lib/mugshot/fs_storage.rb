class Mugshot::FSStorage < Mugshot::Storage
  def write(bin)
    returning asset_id do |id|
      File.open(File.join(@root_path, id), "w") do |fw| 
        fw.write(bin)
      end
    end
  end
  
  def read(id)
    file = File.join(@root_path, id)
    return nil unless File.exist? file
    Mugshot::Image.new File.open(file)
  end
  
  protected
  
  def initialize(root_path)
    @root_path = root_path
    FileUtils.mkdir_p(root_path)
  end
end
