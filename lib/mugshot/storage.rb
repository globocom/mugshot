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

  def id_to_path(id)
    path = id.to_s.clone
    6.times do |i|
      path = path.insert(2 + (i * 2) + i, '/')
    end
    path
  end

end