class Api::DiscountMessagesController < BackofficeController

  # POST /messages
  def create
    new_message_params = message_params.except(:hasOnlineClasses)

    if (message_params[:hasOnlineClasses])
      selected_unit = Unit.left_joins(:students).group(:id).select('COUNT(students.id) as students_count, units.id, units.email').order('students_count ASC').first
      new_message_params[:unidade] = selected_unit[:email]
    end
    
    @message = Message.new(new_message_params)

    if @message.save
      UserMessageMailer.send_message_email(@message).deliver
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:nome, :email, :telefone, :unidade, :curso, :assunto, :hasOnlineClasses)
  end

end
