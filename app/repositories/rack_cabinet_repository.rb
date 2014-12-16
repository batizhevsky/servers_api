class RackCabinetRepository

  def self.create_from_api!(params)
    RackCabinet.create!(name: params[:name],
        dc_location: Location.new(params[:location]))
  end

end
