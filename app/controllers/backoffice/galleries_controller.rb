class Backoffice::GalleriesController < BackofficeController
    before_action :set_gallery, only: [:show, :edit, :update, :destroy]
    has_scope :keyword

    def index
      galleries = apply_scopes(Gallery).all
      @pagy, @galleries = pagy(galleries, items: 6)
    end

    def show
    end

    def new
      @gallery = Gallery.new

    end

    def edit
    end

    def create
      @gallery = Gallery.new(gallery_params)

      respond_to do |format|
        if @gallery.save
          format.html { redirect_to backoffice_gallery_path(@gallery), notice: 'Gallery was successfully created.' }
          format.json { render :show, status: :created, location: backoffice_gallery_path(@gallery) }
        else
          format.html { render :new }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
        end
      end
    end

  def update
    respond_to do |format|

      if @gallery.update(gallery_params)
        format.html { redirect_to backoffice_gallery_path(@gallery), notice: 'Gallery was successfully updated.' }
        format.json { render :show, status: :ok, location: @gallery }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end

    end
  end

  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_galleries_path, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gallery_params
    params.require(:gallery).permit(
      images: []
    )
  end

end
