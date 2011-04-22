# -*- encoding: utf-8 -*-
require 'uuid'
class Mugshot::Storage

  def write(bin)
    nil
  end

protected

  def asset_id
    UUID.generate :compact
  end

end