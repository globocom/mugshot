# -*- encoding: utf-8 -*-
class Mugshot::Image

  def width
    @image.columns
  end

  def height
    @image.rows
  end

  def resize!(size)
    w, h = size.to_s.split("x").map{|i| i.blank? ? nil : i.to_i}

    if [w, h].include?(nil)
      @image.resize_to_fit! w, h
    else
      @image.resize! w, h
    end

    self
  end

  def destroy!
    @image.destroy!
    self
  end

  def to_blob(opts = {})
    @image.strip!
    @image.to_blob do
      self.format = opts[:format].to_s if opts[:format].present?
      self.quality = opts[:quality] if opts[:quality].present?
    end
  end

  protected

  def initialize(file)
    @image = Magick::Image.read(file).first
  end

end
