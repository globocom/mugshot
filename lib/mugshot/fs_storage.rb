# -*- encoding: utf-8 -*-
require 'fileutils'
class Mugshot::FSStorage < Mugshot::Storage
  def write(bin)
    asset_id.tap do |id|
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
