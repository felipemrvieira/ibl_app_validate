class Backoffice::CoursesController < BackofficeController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
    @course.levels.build

    authorize @course
  end

  def edit
    authorize @course
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
          format.html { redirect_to backoffice_course_path(@course), notice: 'Course was successfully created.' }
          format.json { render :show, status: :created, location: backoffice_course_path(@course) }
      else
          format.html { render :new }
          format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
          format.html { redirect_to backoffice_courses_path(@course), notice: 'Course was successfully updated.' }
          format.json { render :show, status: :ok, location: @course }
      else
          format.html { render :edit }
          format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @course
    @course.destroy
    respond_to do |format|
        format.html { redirect_to backoffice_courses_path, notice: 'Course was successfully destroyed.' }
        format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(
      :title,
      :language,
      :description,
      :level_id,
      :course_flag,
      :site_flag,
      :published,
      :cover,
      :inner,
      :order,
      :course_id,
      levels_attributes: [:id, :title, :_destroy]).merge(unit_id: current_unit.id)
  end

end
