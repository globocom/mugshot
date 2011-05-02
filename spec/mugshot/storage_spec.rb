# -*- encoding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mugshot::Storage do
  it "should convert an id to path with 6 levels of directories" do
    @fs = Mugshot::Storage.new
    @fs.send(:id_to_path, "a9657a30c7df012c736512313b021ce1").should == "a9/65/7a/30/c7/df/012c736512313b021ce1"
  end
end
