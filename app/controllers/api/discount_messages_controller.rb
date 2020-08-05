class Api::DiscountMessagesController < BackofficeController

  # POST /messages
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

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:nome, :email, :telefone, :unidade, :curso, :assunto, )
  end

end
