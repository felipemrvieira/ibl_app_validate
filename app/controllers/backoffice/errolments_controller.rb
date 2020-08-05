class Backoffice::ErrolmentsController < BackofficeController
  before_action :set_errolment, only: [:show, :edit, :update, :destroy, :change_status]

  has_scope :by_units, type: :array
  has_scope :keyword


  def change_status
    @errolment.toggle(:active)
    if @errolment.save
      redirect_to backoffice_errolments_path, notice: 'Errolment status was successfully updated.'
    end
  end

  # GET /errolments
  # GET /errolments.json
  def index
   
    # Utiliza Escopo definido no modelo para filtragem
    all_errolments = apply_scopes(Errolment).all
    # para escopo do pundit
    errolments = policy_scope(all_errolments)
    # Paginação
    @pagy, @errolments = pagy(errolments, items: 6)

  end

  # GET /errolments/1
  # GET /errolments/1.json
  def show
    authorize @errolment
  end

  # GET /errolments/new
  def new
    @errolment = Errolment.new
    @levels = Level.all

    # para escopo do pundit
    @students = policy_scope(Student)
   
  end

  # GET /errolments/1/edit
  def edit
    # para escopo do pundit
    @students = policy_scope(Student)
    authorize @errolment
    @levels = Level.all


  end

  # POST /errolments
  # POST /errolments.json
  def create
    @errolment = Errolment.new(errolment_params)
    @errolment.active = true
    @errolment.expiration = Time.now + 1.year

    respond_to do |format|
      if @errolment.save
        format.html { redirect_to backoffice_errolment_path(@errolment), notice: 'Errolment was successfully created.' }
        format.json { render :show, status: :created, location: backoffice_errolment_path(@errolment) }
      else
        format.html { render :new }
        format.json { render json: @errolment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /errolments/1
  # PATCH/PUT /errolments/1.json
  def update
    respond_to do |format|
      if @errolment.update(errolment_params)
        format.html { redirect_to backoffice_errolment_path(@errolment), notice: 'Errolment was successfully updated.' }
        format.json { render :show, status: :ok, location: backoffice_errolment_path(@errolment) }
      else
        format.html { render :edit }
        format.json { render json: @errolment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /errolments/1
  # DELETE /errolments/1.json
  def destroy
    @errolment.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_errolments_path, notice: 'Errolment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_errolment
      @errolment = Errolment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def errolment_params
      params.require(:errolment).permit(:student_id, :level_id)
    end
end
