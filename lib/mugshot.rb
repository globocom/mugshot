# -*- encoding: utf-8 -*-
require "active_support/core_ext"

module Mugshot
  autoload :MagickFactory, "mugshot/magick_factory"
  autoload :Image, "mugshot/image"

  autoload :Storage, "mugshot/storage"
  autoload :FSStorage, "mugshot/fs_storage"
  autoload :S3Storage, "mugshot/s3_storage"
  autoload :HTTPStorage, "mugshot/http_storage"

  autoload :Application, "mugshot/application"
end
