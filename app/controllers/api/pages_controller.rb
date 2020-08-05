class Api::PagesController < BackofficeController

  def index
    @pages = Page.all
    render json: @pages
  end

  def show
    @page = Page.friendly.find(params[:id])
    render json: @page
  end

end
