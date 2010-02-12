# -*- encoding: utf-8 -*-
require 'uuid'
class Mugshot::Storage
  protected
  def asset_id
    UUID.generate :compact
  end
end