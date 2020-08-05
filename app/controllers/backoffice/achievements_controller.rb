class Backoffice::AchievementsController < BackofficeController
    before_action :set_achievement, only: [:show, :edit, :update, :destroy]


    def index
        @achievements = Achievement.all
    end

    def new
        @achievement = Achievement.new
    end

    def create
        @achievement = Achievement.new(achievement_params)

        if @achievement.save
            redirect_to backoffice_achievements_path, notice: "The achievement #{@achievement.description} has been created."
        else
            render "new"
        end
    end
    
    def update
        respond_to do |format|
          if @achievement.update(achievement_params)
            format.html { redirect_to backoffice_achievement_path(@achievement), notice: 'achievement was successfully updated.' }
            format.json { render :show, status: :ok, location: @achievement }
          else
            format.html { render :edit }
            format.json { render json: @achievement.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        @achievement = Achievement.find(params[:id])
        @achievement.destroy
        redirect_to backoffice_achievements_path, notice:  "The achievement #{@achievement.description} has been deleted."
    end

    private
    def set_achievement
        @achievement = Achievement.find(params[:id])
    end

    def achievement_params
        params.require(:achievement).permit(:description, :badge_path)
    end
end
