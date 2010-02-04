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

  shared_examples_for 'any GET image' do
    before :each do
       @image = mock(Mugshot::Image, :null_object => true)
       @storage.stub!(:read).with("image_id").and_return(@image)
    end

    it "should destroy image" do
      @image.should_receive(:destroy!)

      perform_get
    end

    it "should return image" do
      @image.stub!(:to_blob).and_return("image data")

      perform_get

      last_response.should be_ok
      last_response.body.should == "image data"
    end

    it "should halt 404 when image doesn't exist" do
      @storage.stub!(:read).with("image_id").and_return(nil)

      perform_get

      last_response.should be_not_found
      last_response.body.should be_empty
    end
  end

  describe "GET /:size/:id.:format" do
    def perform_get
      get "/200x200/image_id.jpg"
    end

    it_should_behave_like 'any GET image'

    it "should resize image" do
      @image.should_receive(:resize!).with("200x200")

      perform_get
    end
  end

  describe "GET /:ops/:ops_params/:id.:format" do
    def perform_get
      get "/crop/140x105/image_id.jpg"
    end

    it_should_behave_like 'any GET image'

    it "should perform operations on image" do
      @image.should_receive(:resize!).with("140x140")
      @image.should_receive(:crop!).with("140x105")

      get "/resize/140x140/crop/140x105/image_id.jpg"
    end

    it "should halt 404 on operations that are not allowed" do
      @image.should_not_receive(:operation!)

      get "/operation/140x105/image_id.jpg"
    end
  end
  
  describe "GET /" do
    it "should return ok as healthcheck" do
      get "/"
      
      last_response.should be_ok
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
