Mugshot
=======

**Mugshot is a dead simple image server**.


Overview
--------

The basic idea of Mugshot is that you upload the largest/highest quality images
possible. When retrieving the images you apply different operations to it such
as: resizing, rounded corners, transparency and anything else we can think of!

Only the original image is stored on the server. All operations are performed
dynamically, which is why caching is so important (see below).


Caching
-------

Mugshot doesn't cache anything by itself but is designed to play nice with
standard HTTP caching.

For production use, don't even think about using Mugshot without something like
Varnish or Squid sitting in front.


Supported operations
--------------------

### Resize

/widthxheight/id.jpg (ex: http://mugshot.ws/200x100/test.jpg)

### Resize keeping aspect ratio

/widthx/id.jpg (ex.: http://mugshot.ws/200x/test.jpg)

/xheight/id.jpg (ex.: http://mugshot.ws/x100/test.jpg)


Who's using
-----------

We currently use Mugshot with Varnish on [Baixatudo](http://www.baixatudo.com.br).
