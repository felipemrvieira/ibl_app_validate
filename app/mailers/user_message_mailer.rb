class UserMessageMailer < ApplicationMailer
  default :from => 'website@iblsemlegendas.com.br'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_message_email(message)
    @message = message
    @email_gerencia = Unit.where(manager: :true).first.email_message

    if message.unidade != ""
      @unidade = Unit.where(email_message: message.unidade).last.title
    end

    if message.curso != ""
      @curso = message.curso
    end

    if message.assunto
      assunto = message.assunto
    else
      if message.curso != ""
        assunto = "Agendamento de experiência"
      else
        assunto = 'Mensagem do site'
      end
    end

    mail(
      # :to => "redirecionador@ibl-idiomas.com",
      :to => @email_gerencia,
      :cc => @message.unidade,
      :subject => assunto
    )
  end
end
