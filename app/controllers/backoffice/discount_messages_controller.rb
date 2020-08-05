class Backoffice::DiscountMessagesController < BackofficeController

  before_action :set_message, only: [:show, :edit, :update, :destroy]

  def index
    @messages = DiscountMessage.where(curso: [nil, ""]).reverse_order
  end

  def sign_form
    @messages = Message.where.not(curso: [nil, ""]).reverse_order
  end

  def show
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
    @message = DiscountMessage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:nome, :email, :telefone, :unidade, :assunto, :corpo)
  end

end
