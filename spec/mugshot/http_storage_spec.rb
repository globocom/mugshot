# -*- encoding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'fakeweb'

describe Mugshot::HTTPStorage do
  before :each do
    @storage = Mugshot::HTTPStorage.new{|id| "http://foo.com:123/any/#{id}/abc.jpg"}

    FakeWeb.register_uri(:get, 'http://foo.com:123/any/image_id/abc.jpg', :body => "blob")
    FakeWeb.register_uri(:get, 'http://foo.com:123/any/does_not_exist/abc.jpg', :status => 404)
  end

  it "should read image from another mugshot" do
    Mugshot::Image.should_receive(:new).with("blob").and_return("image")
    
    @storage.read("image_id").should == "image"
  end
  
  it "should return nil if image does not exist in the other mugshot" do
    @storage.read("does_not_exist").should be_nil
  end
end