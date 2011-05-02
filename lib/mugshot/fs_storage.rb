# -*- encoding: utf-8 -*-
require 'fileutils'
class Mugshot::FSStorage < Mugshot::Storage
  def write(bin)
    id = asset_id
    path = id_to_path(id)
    FileUtils.mkdir_p(File.dirname(File.join(@root_path, path)))
    File.open(File.join(@root_path, path), "w") do |fw|
      fw.write(bin)
    end
    id
  end

  def read(id)
    path = id_to_path(id)
    file = File.join(@root_path, path)
    return nil unless File.exist? file
    Mugshot::Image.new File.open(file)
  end

protected

  def initialize(root_path)
    @root_path = root_path
    FileUtils.mkdir_p(root_path)
  end

end

