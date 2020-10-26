class Backoffice::InstructionsController < BackofficeController

  before_action :set_instruction, only: [:show, :edit, :update, :destroy]

  def index
    @instructions = Instruction.all
  end

  def show
  end

  def new
    @instruction = Instruction.new
  end

  def edit
  end

  def create
    @instruction = Instruction.new(instruction_params)
    respond_to do |format|
      if @instruction.save
        format.html { redirect_to backoffice_instruction_path(@instruction), notice: 'A Instrução foi criada com sucesso.' }
        format.json { render :show, status: :created, location: backoffice_instruction_path(@instruction) }
      else
        format.html { render :new }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backoffice/questions/1
  # PATCH/PUT /backoffice/questions/1.json
  def update
    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to backoffice_instruction_path(@instruction), notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: backoffice_instruction_path(@instruction) }
      else
        format.html { render :edit }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @instruction.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_instructions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instruction
      @instruction = Instruction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instruction_params
      params.require(:instruction).permit(:description)
    end

end



