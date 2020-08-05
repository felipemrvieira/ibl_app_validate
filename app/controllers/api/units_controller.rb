class Api::UnitsController < BackofficeController

  def index
    @units = Unit.where(published: :true).joins(:address).order(state: :asc)
    render json: @units, :include => :address
  end

  def states
    @addresses = Address.joins(:unit).where(units: {published: :true}).order(state: :asc).distinct.pluck(:state)
    render json: @addresses
  end

  def cities
    @addresses = Address.joins(:unit).where(units: {published: :true}).as_json(only: [:state, :city])
    render json: @addresses
  end

  def show
    @unit = Unit.friendly.find(params[:id])
    render json: @unit, :include => :address
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def unit_params
    params.require(:unit).permit(
      :title,
      :email,
      :location,
      :password,
      :password_confirmation,
      address_attributes: [:id, :street, :neighborhood, :number, :state, :city],
      )
  end

end
