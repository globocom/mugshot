# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'fog'

describe Mugshot::S3Storage do
  before :each do
    Fog.mock!
    @fs = Mugshot::S3Storage.new(:bucket_name => 'bucket_name', :access_key_id => 'access_key_id', :secret_access_key => 'secret_access_key')
    @bin = File.open("spec/files/test.jpg").read
  end

  it "should write an image to the filesystem and read it back" do
    image = Mugshot::Image.new(File.open("spec/files/test.jpg"))
    Mugshot::Image.stub!(:new).and_return(image)

    id = @fs.write(@bin)

    image2 = @fs.read(id)
    image2.should == image
  end

  it "should return nil when an image with the given id doesn't exist on the filesystem" do
    @fs.read('nonexistant-id').should be_nil
  end
end
