class Backoffice::PagesController < BackofficeController

  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end

  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    respond_to do |format|
      if @page.save
        format.html { redirect_to backoffice_page_path(@page), notice: 'A Lição foi criada com sucesso.' }
        format.json { render :show, status: :created, location: backoffice_page_path(@page) }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

def update
  respond_to do |format|
    if @page.update(page_params)
      format.html { redirect_to backoffice_page_path(@page), notice: 'A Lição foi atualizada com sucesso.' }
      format.json { render :show, status: :ok, location: backoffice_pages_page(@page) }
    else
      format.html { render :edit }
      format.json { render json: @page.errors, status: :unprocessable_entity }
    end
  end
end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_pages_path(), notice: 'A Lição foi excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:title, :body)
  end

end
