class Mugshot::Storage
  
  protected
  
  def asset_id
    UUID.generate :compact
  end
end