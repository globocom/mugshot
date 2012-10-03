Deprecated
==========

**Mugshot has been deprecated and is no longer maintained**.


Mugshot
=======

**Mugshot is a dead simple image server**.


Overview
--------

The basic idea of Mugshot is that you upload the largest/highest quality images possible. When retrieving the images you apply different operations to it such as: resizing, rounded corners, transparency and anything else we can think of!

Only the original image is stored on the server. All operations are performed dynamically, which is why caching is so important (see below).


Caching
-------

Mugshot doesn't cache anything by itself but is designed to play nice with standard HTTP caching.

For production use, don't even think about using Mugshot without something like Varnish or Squid sitting in front.


Using
-----

Mugshot provides you with a Sinatra application. You can create a **config.ru** file with these contents to start using Mugshot:


Using activeresource (3.0.6)
Then you can run it with:

    $ rackup config.ru

And access in your browser:

    http://localhost:9292/myimg/some-name.jpg

This would simply return the image located at /tmp/mugshot/myimg, converting it to a JPEG. Additionaly you can pass some operations to be performed over the image:

  http://localhost:9292/resize/100x100/myimg/some-name.jpg   # resizing to 100x100 pixels
  http://localhost:9292/resize/100x/myimg/some-name.jpg   # resizing to 100 pixels in width maintaining aspect ratio
  http://localhost:9292/resize/x100/myimg/some-name.jpg   # resizing to 100 pixels in height maintaining aspect ratio
  http://localhost:9292/crop/200x150/myimg/some-name.jpg   # resize and crop image to 200x150
  http://localhost:9292/quality/70/crop/200x150/myimg/some-name.jpg   # convert it to JPEG with quality of 70% and resize and crop image to 200x150
  http://localhost:9292/background/red/crop/200x150/myimg/some-name.jpg   # convert it to JPEG with red background and resize and crop image to 200x150

Supported operations
--------------------

### Resize

    /resize/WIDTHxHEIGHT/id/name.jpg (ex: http://mugshot.ws/resize/200x100/myid/thumb.jpg)

### Resize keeping aspect ratio

    /resize/WIDTHx/id/name.jpg (ex: http://mugshot.ws/resize/200x/myid/thumb.jpg)

    /resize/xHEIGHT/id/name.jpg (ex: http://mugshot.ws/resize/x100/myid/thumb.jpg)

### Crop

    /crop/WIDTHxHEIGHT/id/name.jpg (ex: http://mugshot.ws/crop/200x100/myid/thumb.jpg)

### Quality

    /quality/QUALITY/id/name.jpg (ex: http://mugshot.ws/quality/70/myid/thumb.jpg)

### Background

    /background/COLOR/id/name.jpg (ex: http://mugshot.ws/background/red/myid/thumb.jpg)


Configuration
-------------

You can further configure your Mugshot::Application when creating it, like so:

    # -*- encoding: utf-8 -*-
    require "rubygems"
    require "mugshot"

    run Mugshot::Application.new(
      :storage => Mugshot::FSStorage.new("/tmp/mugshot"),
      :cache_duration => 7.days.to_i,                       # duration set in cache header (in seconds)
      :allowed_sizes => ['640x360', '480x360', '320x240'],  # an array with valid sizes for resize and crop operations
      :allowed_formats => [:jpg, :png],                     # an array with the allowed formats
      :allowed_names => ['thumb', 'img'],                   # an array with the allowed names in the URL
      :quality_range => 1..100,                             # the range of allowed values for quality operations
      :valid_operations => [:crop, :resize, :quality]       # an array with the valid operations
    )

When using the restrictive configurations any value other than the ones allowed will result in a 400 status code being returned. If no restriction is set then any value can be given, which can lead to DOS attacks. Be careful!

Development
-----------

Clone the repository and run:

    $ bundle

This will install all dependencies for you. Then you can run the specs and features:

    $ rake spec
    $ rake cucumber

