class Backoffice::WeeklyChallengeBankQuestionsController < BackofficeController

    before_action :set_bank, only: [:show, :edit, :update, :destroy]


    def index
      @weekly_challenge_bank_questions = WeeklyChallengeBankQuestion.all
    end

    def show
    end

    def new
      @weekly_challenge_bank_question = WeeklyChallengeBankQuestion.new
    end

    def edit
    end

    def create

        @weekly_challenge_bank_question = WeeklyChallengeBankQuestion.new(weekly_challenge_bank_question_params)
        respond_to do |format|
            if @weekly_challenge_bank_question.save
                format.html { redirect_to backoffice_level_path(@weekly_challenge_bank_question.level), notice: 'Bank was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

  def update
    respond_to do |format|
        if @weekly_challenge_bank_question.update(weekly_challenge_bank_question_params)
            format.html { redirect_to backoffice_levels_path(@level), notice: 'level was successfully updated.' }
            format.json { render :show, status: :ok, location: backoffice_levels_path(@level) }
        else
            format.html { render :edit }
            format.json { render json: @level.errors, status: :unprocessable_entity }
        end
    end
  end

    def destroy

      @weekly_challenge_bank_question.destroy
      respond_to do |format|
        format.html { redirect_to backoffice_levels_path, notice: 'bank was successfully destroyed.' }
        format.json { head :no_content }
      end

    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @weekly_challenge_bank_question = WeeklyChallengeBankQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_challenge_bank_question_params
      params.require(:weekly_challenge_bank_question).permit(:title, :level_id)
    end

end
