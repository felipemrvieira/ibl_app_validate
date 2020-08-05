class Api::CoursesController < BackofficeController

  before_action :set_unit, only: [:show]

  def index
    @courses = Course.where(published: :true).order(:order)
    render json: @courses, methods: [:father_course, :children_courses]
  end

  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

end
