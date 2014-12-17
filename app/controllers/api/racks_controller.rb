class Api::RacksController < Api::ApplicationController
  def index
    @racks = RackCabinetFilter.new(rack_cabinet_scope).call(params)
    render json: @racks.page(params[:page]), serializer: PaginatedSerializer
  end

  def show
    render json: rack_cabinet
  end

  def create
    @rack = Forms::RackCabinet::CreationForm.new.call(params)

    render json: @rack, status: :created
  end

  def update
    updated_rack = Forms::RackCabinet::UpdateForm.new(rack_cabinet).call(params)

    render json: updated_rack
  end

  def destroy
    Forms::RackCabinet::DestroyForm.new(rack_cabinet).call

    render nothing: true
  end

  private

  def rack_cabinet
    @rack_cabinet ||= rack_cabinet_scope.find(params[:id])
  end

  def rack_cabinet_scope
    RackCabinet
  end
end
