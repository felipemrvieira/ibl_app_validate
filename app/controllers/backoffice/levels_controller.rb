class Backoffice::LevelsController < BackofficeController

    before_action :set_level, only: [:show, :edit, :update, :destroy]


    def index
        @levels = Level.all
    end

    def show
        @path = Path.new
        @audio_version = AudioVersion.new
        @weekly_challenge_bank_question = WeeklyChallengeBankQuestion.new
    end

    def new
        @level = Level.new
        @course_options = Course.all
        authorize @level
    end

    def edit
        @course_options = Course.all
        authorize @level

    end

    def create
        authorize @level

        @level = Level.new(level_params)
        respond_to do |format|
            if @level.save
                format.html { redirect_to backoffice_level_path(@level), notice: 'Level was successfully created.' }
                format.json { render :show, status: :created, location: backoffice_level_path(@level) }
            else
                format.html { render :new }
                format.json { render json: @level.errors, status: :unprocessable_entity }
            end
        end
    end

  def update
    respond_to do |format|
        if @level.update(level_params)
            format.html { redirect_to backoffice_levels_path(@level), notice: 'level was successfully updated.' }
            format.json { render :show, status: :ok, location: backoffice_levels_path(@level) }
        else
            format.html { render :edit }
            format.json { render json: @level.errors, status: :unprocessable_entity }
        end
    end
  end

    def destroy
        authorize @level

        @level.destroy
        respond_to do |format|
            format.html { redirect_to backoffice_levels_path, notice: 'level was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_level
      @level = Level.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def level_params
      params.require(:level).permit(:title, :course_id)
    end

end
