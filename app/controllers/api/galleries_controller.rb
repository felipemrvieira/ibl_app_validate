class Api::GalleriesController < BackofficeController
  before_action :set_galleries, only: [:show]

  def last
    @galleries = Gallery.last
    render json: @galleries
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_galleries
    @gallery = Gallery.find(params[:id])
  end

end
