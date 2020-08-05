class Backoffice::StudentAchievementsController < BackofficeController
    before_action :set_student_achievement, only: [:show, :edit, :update, :destroy]


    def by_unit
        @student_achievements = StudentAchievement.joins(:student).where('students.unit_id = ?', current_unit.id)
    end
    
    def index
        @student_achievements = StudentAchievement.all
    end

    def new
        @student_achievement = StudentAchievement.new
    end

    def create
        @student_achievement = StudentAchievement.new(achievement_params)

        if @student_achievement.save
            redirect_to backoffice_student_achievements_path, notice: "A conquista #{@student_achievement.achievement.description} foi atribuída a #{@student_achievement.student.name}."
        else
            render "new"
        end
    end
    
    def update
        respond_to do |format|
          if @student_achievement.update(achievement_params)
            format.html { redirect_to backoffice_student_achievements_path(@student_achievement), notice: "A conquista #{@student_achievement.achievement.description} foi atribuída a #{@student_achievement.student.name} foi atualizada." }
            format.json { render :show, status: :ok, location: @student_achievement }
          else
            format.html { render :edit }
            format.json { render json: @student_achievement.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        @student_achievement = StudentAchievement.find(params[:id])
        @student_achievement.destroy
        redirect_to backoffice_student_achievements_path, notice:  "A conquista #{@student_achievement.achievement.description} foi atribuída a #{@student_achievement.student.name} foi excluída."
    end

    private
    def set_student_achievement
        @student_achievement = StudentAchievement.find(params[:id])
    end

    def achievement_params
        params.require(:student_achievement).permit(:student_id, :achievement_id)
    end
end
