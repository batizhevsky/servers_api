class Api::HostsController < Api::ApplicationController
  def index
    @hosts = HostsFilter.new(host_scope).call(params)
    render json: @hosts.page(params[:page]), serializer: PaginatedSerializer
  end

  def show
    render json: host
  end

  def create
    @rack = Forms::Host::CreationForm.new.call(params)

    render json: @rack, status: :created
  end

  def update
    updated_rack = Forms::Host::UpdateForm.new(host).call(params)

    render json: updated_rack
  end

  def destroy
    Forms::Host::DestroyForm.new(host).call

    render nothing: true
  end

  private

  def host
    @host ||= host_scope.find(params[:id])
  end

  def host_scope
    Host
  end
end
