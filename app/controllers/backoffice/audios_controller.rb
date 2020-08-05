class Backoffice::AudiosController < BackofficeController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]


  def index
    @audios = Audio.all
  end

  def new
    @audio = Audio.new
  end

  def edit
  end

  def create
    @audio = Audio.new(audio_params)

    if @audio.save
      redirect_to backoffice_audios_path, notice: "The audio #{@audio.title} has been uploaded."
    else
      render "new"
    end
  end

  def update
    respond_to do |format|
        if @audio.update(audio_params)
            format.html { redirect_to backoffice_audios_path, notice: 'O audio foi atualizado.' }
            format.json { render :show, status: :ok, location: @audio }
        else
            format.html { render :edit }
            format.json { render json: @audio.errors, status: :unprocessable_entity }
        end
    end
  end

  def destroy
    @audio = Audio.find(params[:id])
    @audio.destroy
    redirect_to backoffice_audios_path, notice:  "The audio #{@audio.title} has been deleted."
  end

private
  def set_audio
    @audio = Audio.find(params[:id])
  end

  def audio_params
    params.require(:audio).permit(:title, :attachment, :level_id, :audio_version_id )
  end
end
