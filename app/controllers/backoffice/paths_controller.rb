class Backoffice::PathsController < BackofficeController

    before_action :set_path, only: [:show, :edit, :update, :destroy]

    def index
        @levels = Level.all
    end

    def show
        @pagy, @questions = pagy(@path.questions, items: 6)
    end
  
    def new
        @level = Level.new
        @course_options = Course.all
    end
  
    def edit
        # @course_options = Course.all
        authorize @path
    end

    def create
        @path = Path.new(path_params)
        authorize @path
        respond_to do |format|
            if @path.save
                format.html { redirect_to backoffice_level_path(@path.level), notice: 'A Lição foi criada com sucesso.' }
                format.json { render :show, status: :created, location: backoffice_level_path(@path.level) }
            else
                format.html { render :new }
                format.json { render json: @path.errors, status: :unprocessable_entity }
            end
        end
    end

  def update
    respond_to do |format|
        if @path.update(path_params)
            format.html { redirect_to backoffice_path_path(@path), notice: 'A Lição foi atualizada com sucesso.' }
            format.json { render :show, status: :ok, location: backoffice_paths_path(@path) }
        else
            format.html { render :edit }
            format.json { render json: @path.errors, status: :unprocessable_entity }
        end
    end
  end

    def destroy
        authorize @path
        @path.destroy
        respond_to do |format|
            format.html { redirect_to backoffice_level_path(@path.level), notice: 'A Lição foi excluída com sucesso.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_path
      @path = Path.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def path_params
      params.require(:path).permit(:title, :level_id)
    end

end
