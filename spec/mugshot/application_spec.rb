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

  shared_examples_for 'GET images' do
    before :each do
       @image = mock(Mugshot::Image, :null_object => true)
       @storage.stub!(:read).with("image_id").and_return(@image)
    end

    it "should resize image" do
      @image.should_receive(:resize!).with("200x200")

      perform_get('jpg')
    end

    it "should convert image to format" do
      @image.should_receive(:to_blob).with(:format => :jpg)
      perform_get('jpg')
      last_response.content_type == "image/jpg"

      @image.should_receive(:to_blob).with(:format => :png)
      perform_get('png')
      last_response.content_type == "image/png"
    end

    it "should destroy image" do
      @image.should_receive(:destroy!)

      perform_get('jpg')
    end

    it "should return image" do
      @image.stub!(:to_blob).and_return("image data")

      perform_get('jpg')

      last_response.should be_ok
      last_response.body.should == "image data"
    end

    it "should halt 404 when image doesn't exist" do
      @storage.stub!(:read).with("image_id").and_return(nil)

      perform_get('jpg')

      last_response.should be_not_found
      last_response.body.should be_empty
    end
  end

  describe "GET /:size/:ops/:ops_params/:id.:ext" do
    def perform_get(format)
      get "/200x200/image_id.#{format}"
    end

    it_should_behave_like 'GET images'
  end

  describe "GET /:size/:ops/:ops_params/:id.:ext" do
    def perform_get(format)
      get "/200x200/crop/140x105/image_id.#{format}"
    end

    it_should_behave_like 'GET images'

    it "should perform operations on image" do
      @image.should_receive(:crop!).with("140x105")

      perform_get('jpg')
    end

    it "should halt 404 on operations that are not allowed" do
      @image.should_not_receive(:operation!)

      get "/200x200/operation/140x105/image_id.jpg"
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
