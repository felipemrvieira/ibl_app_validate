class Backoffice::WeeklyChallengesController < BackofficeController

  before_action :set_weekly_challenge, only: [:show, :edit, :update, :destroy]

  # GET /weekly_challenges
  # GET /weekly_challenges.json
  def index
    @weekly_challenges = WeeklyChallenge.all
  end

  # GET /weekly_challenges/1
  # GET /weekly_challenges/1.json
  def show
  end

  # GET /weekly_challenges/new
  def new
    @weekly_challenge = WeeklyChallenge.new
    @questions = Question.all
  end

  # GET /weekly_challenges/1/edit
  def edit
    @questions = Question.all
  end

  # POST /weekly_challenges
  # POST /weekly_challenges.json
  def create
    @weekly_challenge = WeeklyChallenge.new(weekly_challenge_params)

    respond_to do |format|
      if @weekly_challenge.save
        format.html { redirect_to backoffice_weekly_challenge_path(@weekly_challenge), notice: 'Weekly challenge was successfully created.' }
        format.json { render :show, status: :created, location: backoffice_weekly_challenge_path(@weekly_challenge) }
      else
        format.html { render :new }
        format.json { render json: @weekly_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_challenges/1
  # PATCH/PUT /weekly_challenges/1.json
  def update
    respond_to do |format|
      if @weekly_challenge.update(weekly_challenge_params)
        format.html { redirect_to backoffice_weekly_challenge_path(@weekly_challenge), notice: 'Weekly challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: backoffice_weekly_challenge_path(@weekly_challenge) }
      else
        format.html { render :edit }
        format.json { render json: @weekly_challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_challenges/1
  # DELETE /weekly_challenges/1.json
  def destroy
    @weekly_challenge.destroy
    respond_to do |format|
      format.html { redirect_to weekly_challenges_url, notice: 'Weekly challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_challenge
      @weekly_challenge = WeeklyChallenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_challenge_params
      params.require(:weekly_challenge).permit(:question_id, :exp)
    end
end
