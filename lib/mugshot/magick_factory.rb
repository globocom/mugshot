# -*- encoding: utf-8 -*-
require 'RMagick'

class Mugshot::MagickFactory
  def self.create_canvas(columns, rows, color)
    Magick::Image.new(columns, rows){ self.background_color = color }
  end
end