class Api::RacksController < Api::ApplicationController
  def index
    @racks = RackCabinet.page(params[:page])
    render json: @racks, serializer: PaginatedSerializer
  end

  def create
    @rack = Forms::RackCabinetCreationForm.new.call(params)

    render json: @rack, status: :created
  end

  def update
    rack = RackCabinet.find(params[:id])
    updated_rack = Forms::RackCabinetUpdateForm.new(rack).call(params)

    render json: updated_rack, status: :success
  end

  def destroy
    rack = RackCabinet.find(params[:id])
    Forms::RackCabinetDestroyForm.new(rack).call

    render nothing: true
  end
end
