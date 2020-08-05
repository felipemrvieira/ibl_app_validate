class Backoffice::MessagesController < BackofficeController

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Message.all.reverse_order
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def states
    @addresses = Address.joins(:unit).where(units: {published: :true}).order(state: :asc).distinct.pluck(:state)
    render json: @addresses
  end

  def posts
    @posts = Post.all.reverse_order
    render json: @posts, :include => :categories
  end


  def create
    @message = Message.new(message_params)
    if @message.save
      UserMessageMailer.send_message_email(@message).deliver
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
    # respond_to do |format|
    #   if @message.save
    #     format.html { redirect_to backoffice_message_path(@message), notice: 'A Lição foi criada com sucesso.' }
    #     format.json { render :show, status: :created, location: backoffice_message_path(@message) }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @message.errors, status: :unprocessable_entity }
    #   end
    # end
  end

def update
  respond_to do |format|
    if @message.update(message_params)
      format.html { redirect_to backoffice_message_path(@message), notice: 'A Lição foi atualizada com sucesso.' }
      format.json { render :show, status: :ok, location: backoffice_messages_message(@message) }
    else
      format.html { render :edit }
      format.json { render json: @message.errors, status: :unprocessable_entity }
    end
  end
end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_messages_path(), notice: 'A Lição foi excluída com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:nome, :email, :telefone, :unidade, :assunto, :corpo)
  end

end
