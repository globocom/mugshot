require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mugshot::Image do
  before :each do
    @magick_image = mock(Magick::Image)
    Magick::Image.stub!(:read).and_return([@magick_image])

    @image = Mugshot::Image.new(File.open("spec/files/test.jpg"))
  end
  
  it 'should return image width and height' do
    @magick_image.stub!(:columns).and_return(100)
    @magick_image.stub!(:rows).and_return(200)

    @image.width.should == 100
    @image.height.should == 200
  end

  describe "to blob" do
    before(:each) do
      @magick_image.stub!(:strip!)
      @magick_image.instance_eval do
        def to_blob(&block)
          block.call if block.present?
          return 'blob_data'
        end
      end
    end

    it 'should return image as a blob using default options' do
      @image.to_blob.should == 'blob_data'
    end

    it 'should return image as a blob using quality' do
      @image.should_receive(:quality=).with(75)
      @magick_image.instance_eval do
        def to_blob(&block)
          yield
          return 'blob_data'
        end
      end

      @image.to_blob(:quality => 75).should == 'blob_data'
    end

    it 'should return image as a blob using format' do
      @image.should_receive(:format=).with('png')
      @magick_image.instance_eval do
        def to_blob(&block)
          yield
          return 'blob_data'
        end
      end

      @image.to_blob(:format => :png).should == 'blob_data'
    end

  end
  
  it "should resize image to given width and height" do
    @magick_image.should_receive(:resize!).with(300, 200)
    @image.resize! "300x200"
  end

  it 'should resize image to fit given width' do
    @magick_image.should_receive(:resize_to_fit!).with(300, nil)
    @image.resize! "300x"
  end

  it 'should resize image to fit given height' do
    @magick_image.should_receive(:resize_to_fit!).with(nil, 200)
    @image.resize! "x200"
  end
  
  it 'should destroy image' do
    @magick_image.should_receive(:'destroy!')
    @image.destroy!
  end
  
end