# -*- encoding: utf-8 -*-

When /^I upload an image$/ do
  post '/', "file" => Rack::Test::UploadedFile.new("features/support/files/test.jpg", "image/jpeg")
  @image_id = last_response.body
end

When /^I ask for a (.*) resized image that doesn't exist$/ do |size|
  get "/resize/#{size}/nonexistant_id/any_name.jpg"
end

When /^I ask for the (.*) resized image$/ do |size|
  get "/resize/#{size}/#{@image_id}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for the (.*) cropped image$/ do |size|
  get "/crop/#{size}/#{@image_id}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for an image with (\d*)% of compression$/ do |compression|
  get "/quality/#{compression}/#{@image_id}/any_name.jpg"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
end

When /^I ask for a (.*) image$/ do |format|
  get "/#{@image_id}/any_name.#{format}"
  @retrieved_image = Magick::Image.from_blob(last_response.body).first
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

Then /^I should get a (.*) image$/ do |expected_format|
  @retrieved_image.should be_same_image_as("test.#{expected_format}")
end

Then /^I should get the same image no matter what name I use to get it$/ do
  get "/#{@image_id}/name_1.jpg"
  @image_1 = Magick::Image.from_blob(last_response.body).first
  
  get "/#{@image_id}/name_2.jpg"
  @image_2 = Magick::Image.from_blob(last_response.body).first
  
  @image_1.should be_same_image_as(@image_2)
end