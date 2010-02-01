# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Mugshot::Application do
  before :each do
    @storage = mock(Mugshot::Storage)
    def app
      Mugshot::Application.new(@storage)
    end
  end

  describe "POST /" do
    it "should create image" do
      file_read = nil
      File.open("spec/files/test.jpg") {|f| file_read = f.read}
      @storage.should_receive(:write).with(file_read)

      post "/", "file" => Rack::Test::UploadedFile.new("spec/files/test.jpg", "image/jpeg")

      last_response.status.should == 200
    end

    it "should return image id" do
      @storage.stub!(:write).and_return("batata")

      post "/", "file" => Rack::Test::UploadedFile.new("spec/files/test.jpg", "image/jpeg")

      last_response.body.should == "batata"
    end
  end

  describe "GET /:size/:id.:ext" do
    it "should return resized image" do
      image = mock(Mugshot::Image)
      image.stub!(:to_blob).and_return("image data")
      image.should_receive(:resize!).with("200x200")
      image.should_receive(:destroy!)
      @storage.stub!(:read).with("batata").and_return(image)

      get "/200x200/batata.jpg"

      last_response.status.should == 200
      last_response.content_type == "image/jpg"
      last_response.body.should == "image data"
    end

    it "should halt 404 when image doesn't exist" do
      @storage.stub!(:read).with("batata").and_return(nil)

      get "/200x200/batata.jpg"

      last_response.status.should == 404
      last_response.body.should be_empty
    end
  end

  describe "GET /" do
    it "should return ok as healthcheck" do
      get "/"

      last_response.status.should == 200
      last_response.body.should == "ok"
    end
  end

  describe "before" do
    it "should cache response with max age of 1 day" do
      get "/"
      last_response.headers["Cache-Control"].should == "public, max-age=31557600"
    end
  end
end
