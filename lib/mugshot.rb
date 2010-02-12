# -*- encoding: utf-8 -*-
require "active_support"

module Mugshot
  autoload :Image, "mugshot/image"
  autoload :Storage, "mugshot/storage"
  autoload :FSStorage, "mugshot/fs_storage"
  autoload :Application, "mugshot/application"
  autoload :Proxy, "mugshot/proxy"
end
