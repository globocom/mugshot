# -*- encoding: utf-8 -*-
Given /^(a|an) (.*)Storage$/ do |_, storage_name|
  case storage_name
  when 'FS' then CucumberWorld.storage = Mugshot::FSStorage.new('/tmp/mugshot/cucumber')
  when 'HTTP' then CucumberWorld.storage = Mugshot::HTTPStorage.new
  end
end

Given /^an image$/ do
  Given "a jpg image test"
end

Given /^a (.*) image (.*)$/ do |ext, name|
  @image = {
    :name => name,
    :ext => ext,
    :filename => "#{name.gsub(' ', '_')}.#{ext}"}

  @image[:id] = write_image(@image[:filename])
end

When /^I upload an image$/ do
  post '/', "file" => Rack::Test::UploadedFile.new("features/support/files/test.jpg", "image/jpeg")
  @image_id = last_response.body
end

When /^I ask for it$/ do
  get "/#{@image_id}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for a (.*) resized image that doesn't exist$/ do |size|
  get "/resize/#{size}/nonexistant_id/any_name.jpg"
end

When /^I ask for the (.*) resized image$/ do |size|
  get "/resize/#{size}/#{@image_id}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for it cropped to (.*)$/ do |size|
  get "/crop/#{size}/#{@image[:id]}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for an image with (\d*)% of compression$/ do |compression|
  get "/quality/#{compression}/#{@image_id}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for it with format (.*)$/ do |format|
  get "/#{@image[:id]}/any_name.#{format}"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for it with the name "(.*)"$/ do |name|
  get "/#{@image_id}/#{name}.jpg"
  @images_by_name[name] = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for it with a (.*) background$/ do |color|
  get "/background/#{color}/#{@image[:id]}/img.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

Then /^I should get it$/ do
  @retrieved_image.should be_same_image_as("test.jpg")
end

Then /^I should get a (\d+) response$/ do |response_code|
  last_response.status.should == response_code.to_i
end

Then /^I should get the (.*) resized image$/ do |size|
  @retrieved_image.should be_same_image_as("test.#{size}.jpg")
end

Then /^I should get the (.*) resized image keeping the aspect ratio$/ do |size|
  @retrieved_image.should be_same_image_as("test.#{size}.jpg")
end

Then /^I should get the (.*) cropped image$/ do |size|
  @retrieved_image.should be_same_image_as("test.crop.#{size}.jpg")
end

Then /^I should get a image with (\d*)% of compression$/ do |compression|
  @retrieved_image.should be_same_image_as("test.quality.#{compression}.jpg")
end

Then /^I should get it with format (.*)$/ do |expected_format|
  @retrieved_image.should be_same_image_as("test.#{expected_format}")
end

Then /^I should get it (.*)$/ do |name|
  @retrieved_image.should be_same_image_as("#{@image[:name].gsub(' ', '_')}-#{name.underscore.gsub(' ', '_')}.jpg")
end

Then /^all of them should be the same$/ do
  @images_by_name.values.each do |img|
    img.should be_same_image_as("test.jpg")
  end
end