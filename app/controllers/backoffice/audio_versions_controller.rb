class Backoffice::AudioVersionsController < BackofficeController

  before_action :set_audio_version, only: [:show, :edit, :update, :destroy]

  # GET /audio_versions
  # GET /audio_versions.json
  def index
    @audio_versions = AudioVersion.all
  end

  # GET /audio_versions/1
  # GET /audio_versions/1.json
  def show
  end

  # GET /audio_versions/new
  def new
    @audio_version = AudioVersion.new
  end

  # GET /audio_versions/1/edit
  def edit
  end

  # POST /audio_versions
  # POST /audio_versions.json
  def create
    @audio_version = AudioVersion.new(audio_version_params)

    respond_to do |format|
      if @audio_version.save
        format.html { redirect_to backoffice_level_path(@audio_version.level), notice: 'Audio version was successfully created.' }
        format.json { render :show, status: :created, location: @audio_version }
      else
        format.html { render :new }
        format.json { render json: @audio_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /audio_versions/1
  # PATCH/PUT /audio_versions/1.json
  def update
    respond_to do |format|
      if @audio_version.update(audio_version_params)
        format.html { redirect_to backoffice_audio_versions_path, notice: 'Audio version was successfully updated.' }
        format.json { render :show, status: :ok, location: @audio_version }
      else
        format.html { render :edit }
        format.json { render json: @audio_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audio_versions/1
  # DELETE /audio_versions/1.json
  def destroy
    @audio_version.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_audio_versions_path, notice: 'Audio version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio_version
      @audio_version = AudioVersion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_version_params
      params.require(:audio_version).permit(:title, :level_id)
    end
end
