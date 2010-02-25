# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mugshot::MagickFactory do

  it "should create a canvas given columns, rows and background color" do
    canvas = Mugshot::MagickFactory.create_canvas(100, 200, 'red')
    canvas.columns.should == 100
    canvas.rows.should == 200
    canvas.background_color == 'red'
  end

end
