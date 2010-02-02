# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Mugshot::Proxy do
  before :each do
    def app
      Mugshot::Proxy.new("http://localhost:9292")
    end
  end

  describe 'GET /*' do
    before :each do
      @http = stub(Net::HTTP, :null_object => true)
      @res = stub(Net::HTTPResponse, :null_object => true)
      @http.stub!(:get).with('/request/path').and_return(@res)
      Net::HTTP.stub!(:start).with("localhost", 9292).and_yield(@http)
    end

    it 'should proxy the request to configured host' do
      @res.stub!(:body).and_return('body')

      get '/request/path'

      last_response.body.should == 'body'
    end

    it 'should return original response headers' do
      @res.stub!(:each_header)\
        .and_yield('content-type', 'image/jpg')\
        .and_yield('cache-control', 'public, max-age=31557600')

      get '/request/path'

      last_response.headers['content-type'].should == 'image/jpg'
      last_response.headers['cache-control'].should == 'public, max-age=31557600'
    end

    it 'should return original status' do
      @res.stub!(:code).and_return('404')

      get '/request/path'

      last_response.status.should == 404
    end

    it 'should not return status header' do
      @res.stub!(:each_header).and_yield('status', '200')

      get '/request/path'

      last_response.headers.should_not include('status')
    end
  end

  describe 'other methods' do
    it 'should not be allowed' do
      post '/request/path'
      last_response.status.should == 405

      put '/request/path'
      last_response.status.should == 405

      delete '/request/path'
      last_response.status.should == 405
    end
  end
end