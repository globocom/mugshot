# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mugshot::Image do
  before :each do
    @magick_image = mock(Magick::Image, :null_object => true, :columns => 100, :rows => 100)
    @magick_image.instance_eval do # TODO: Explain it
      def to_blob(&block)
        block.call if block.present?
        return 'blob_data'
      end
    end

    Magick::Image.stub!(:read).and_return([@magick_image])
    
    @image = Mugshot::Image.new(File.open("spec/files/test.jpg"))
  end
  
  it 'can be initialized with blob' do
    Magick::Image.should_receive(:from_blob).and_return([@magick_image])
    Mugshot::Image.new("blob")
  end

  describe "to blob" do
    it 'should return image as a blob using default options' do
      @image.to_blob.should == 'blob_data'
    end

    it 'should return image as a blob using format' do
      @image.should_receive(:format=).with('png')
      @image.to_blob(:format => :png).should == 'blob_data'
    end
  end

  it 'should return image as a blob using quality' do
    @image.should_receive(:quality=).with(75)

    @image.quality!("75")
    @image.to_blob
  end
  
  it 'should set background for transparent images' do
    canvas = mock(Magick::Image)
    Mugshot::MagickFactory.stub!(:create_canvas).and_return(canvas)
    canvas.should_receive(:composite).
      with(@magick_image, Magick::NorthWestGravity, Magick::OverCompositeOp).
      and_return(@magick_image)

    @image.background!("gray")
    @image.to_blob
  end

  it "should resize image to given width and height" do
    @magick_image.should_receive(:resize!).with(300, 200)
    @image.resize! "300x200"
  end

  it 'should resize image to fit given width' do
    @magick_image.should_receive(:resize_to_fit!).with(300, nil)
    @image.resize! "300x"
  end

  it 'should resize image to fit given height' do
    @magick_image.should_receive(:resize_to_fit!).with(nil, 200)
    @image.resize! "x200"
  end

  it "should crop image to given width and height" do
    @magick_image.should_receive(:resize_to_fill!).with(140, 105)
    @image.crop! "140x105"
  end

  it 'should destroy image' do
    @magick_image.should_receive(:'destroy!')
    @image.destroy!
  end

end

