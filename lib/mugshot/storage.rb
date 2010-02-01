# -*- encoding: utf-8 -*-
class Mugshot::Storage
  protected
  def asset_id
    UUID.generate :compact
  end
end