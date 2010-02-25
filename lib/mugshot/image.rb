# -*- encoding: utf-8 -*-
require 'RMagick'
class Mugshot::Image

  def background!(color)
    @background_color = color
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

    set_background(@background_color) if !!@background_color

    @image.strip!
    @image.to_blob do
      self.format = opts[:format].to_s if opts.include?(:format)
      self.quality = opts[:quality] if opts[:quality].present?
    end
  end

  protected
  def initialize(file_or_blob)
    if file_or_blob.is_a?(File)
      @image = Magick::Image.read(file_or_blob).first
    else
      @image = Magick::Image.from_blob(file_or_blob).first
    end
    
    # initialize attrs
    @background_color = @quality = nil
  end

  private
  def parse_size(size)
    size.to_s.split("x").map{|i| i.blank? ? nil : i.to_i}
  end

  def set_background(color)
    @image = Mugshot::MagickFactory.
      create_canvas(@image.columns, @image.rows, color).
      composite(@image, Magick::NorthWestGravity, Magick::OverCompositeOp)
  end
end

