When /^I upload an image$/ do
  post '/', "file" => Rack::Test::UploadedFile.new("features/support/files/test.jpg", "image/jpeg")
  @image_id = last_response.body
end

When /^I ask for the (.*) resized image$/ do |size|
  get "/#{size}/#{@image_id}.jpg"
  @retrieved_image = last_response.body
end

When /^I ask for a (.*) resized image that doesn't exist$/ do |size|
  get "/#{size}/nonexistant.jpg"
end

When /^I ask for the (.*) image cropped to (.*)$/ do |size, crop|
  pending
  get "/#{size}/crop/#{crop}/#{@image_id}.jpg"
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

Then /^I should get the (.*) image cropped to (.*)$/ do |size, crop|
  @retrieved_image.should be_same_image_as("test.#{size}.cropped.#{crop}.jpg")
end
