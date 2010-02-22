# -*- encoding: utf-8 -*-
require 'RMagick'
class Mugshot::Image
  def width
    @image.columns
  end

  def height
    @image.rows
  end

  def resize!(size)
    w, h = parse_size(size)

    if [w, h].include?(nil)
      @image.resize_to_fit! w, h
    else
      @image.resize! w, h
    end

    self
  end

  def crop!(size)
    w, h = parse_size(size)
    @image.resize_to_fill! w, h
    self
  end

  def quality!(quality)
    @quality = quality.to_i
    self
  end

  def destroy!
    @image.destroy!
    self
  end

  def to_blob(opts = {})
    opts.merge!(:quality => @quality)
    @image.strip!
    @image.to_blob do
      self.format = opts[:format].to_s if opts.include?(:format)
      self.quality = opts[:quality] if opts[:quality].present?
    end
  end

  protected
  def initialize(file)
    @image = Magick::Image.read(file).first
    @quality = nil
  end

  private

  def parse_size(size)
    size.to_s.split("x").map{|i| i.blank? ? nil : i.to_i}
  end
end
