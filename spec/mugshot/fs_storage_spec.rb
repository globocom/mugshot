# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mugshot::FSStorage do
  before :each do
    @fs = Mugshot::FSStorage.new("/tmp/mugshot/spec")
  end

  after :each do
    require 'fileutils'
    FileUtils.rm_rf("/tmp/mugshot/spec")
  end

  it "should write an image to the filesystem and read it back" do
    bin = File.open("spec/files/test.jpg").read

    image = Mugshot::Image.new File.open("spec/files/test.jpg")
    Mugshot::Image.stub!(:new).and_return(image)

    id = @fs.write(bin)
    
    image2 = @fs.read(id)
    image2.should == image
  end

  it "should return nil when an image with the given id doesn't exist on the filesystem" do
    @fs.read('nonexistant-id').should be_nil
  end
end
