# -*- encoding: utf-8 -*-
require 'fileutils'
class Mugshot::FSStorage < Mugshot::Storage
  def write(bin)
    asset_id.tap do |id|
      @old_id = String.new(id)
      path = define_path(id)
      FileUtils.mkdir_p(File.join(@root_path, path.split("/")[0..6].join("/")))
      File.open(File.join(@root_path, path), "w") do |fw|
        fw.write(bin)
      end
    end
    @old_id
  end

  def read(id)
    path = define_path(id)
    file = File.join(@root_path, path)
    return nil unless File.exist? file
    Mugshot::Image.new File.open(file)
  end

  protected

  def initialize(root_path)
    @root_path = root_path
    FileUtils.mkdir_p(root_path)
  end

  private

  def define_path(id)
    path = String.new(id)
    begin
      7.times { |i| path = path.insert(3 + (i * 4), "/") }
    rescue IndexError => index_error
      p index_error
    end
    path
  end
end

