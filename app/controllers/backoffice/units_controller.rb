class Backoffice::UnitsController < BackofficeController
    before_action :set_unit, only: [:show, :edit, :update, :destroy]
    has_scope :keyword

    def index
      units = apply_scopes(Unit).all
      @pagy, @units = pagy(units, items: 6)
    end

    def show
    end

    def new
      @unit = Unit.new
      @unit.address = Address.new
      @address = @unit.address

      authorize @unit

    end

    def edit
      if @unit.address == nil
        @unit.address = Address.create(city: "Maceió")
        @address = @unit.address
      end

      authorize @unit
    end

    def create
      @unit = Unit.new(unit_params)

      respond_to do |format|
        if @unit.save
          format.html { redirect_to backoffice_unit_path(@unit), notice: 'Unit was successfully created.' }
          format.json { render :show, status: :created, location: backoffice_unit_path(@unit) }
        else
          format.html { render :new }
          format.json { render json: @unit.errors, status: :unprocessable_entity }
        end
      end
    end

  def update


    respond_to do |format|

      if params[:unit][:password].blank?
        params[:unit].delete(:password)
        params[:unit].delete(:password_confirmation)
      end

      if @unit.update(unit_params)
        format.html { redirect_to backoffice_unit_path(@unit), notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end

    end
  end

  def destroy
    authorize @unit
    @unit.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_units_path, notice: 'Unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_unit
    @unit = Unit.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def unit_params
    params.require(:unit).permit(
      :title,
      :email,
      :email_message,
      :location,
      :password,
      :password_confirmation,
      :phone,
      :site,
      :published,
      :admin,
      :cover,
      :has_online_classes,
      :has_presential_classes,
      {images: []},
      address_attributes: [
        :id,
        :street,
        :neighborhood,
        :number,
        :state,
        :city,
        :latitude,
        :longitude,
      ],
    )
  end

end
