class Site::WeeklyChallengeQuizzesController < ApplicationController
  layout "site"

  def create
    student_id = params[:student_id]
    @weekly_challenge_id = params[:weekly_challenge_id]
    # tratar no tipo de questao
    hit = false
    resposta_aluno = params[:question_text]
    question_id = params[:question_id]
    @acerto_forca = false

    # INCREMENTO DA FORCA
    # remove se tiver acertado
    @incrementa = true

    question = Question.find(question_id)
    @question = question

    puts question.type_question

    if question.type_question == "Múltipla Escolha"
      resposta_multipla_escolha_aluno = params[:quiz][:question_option_id]
      @acerto = QuestionOption.find(resposta_multipla_escolha_aluno).correct
      puts @acerto
      opcao = question.question_options.where(:correct => true).first
      resposta = opcao.option_description
      puts resposta

      pontua(@acerto, 20)

    elsif question.type_question == "Combinação"
      # recebe a combinacao, transforma num array e verifica se as posicoes estao corretas
      resposta_aluno = params[:question_text].split(':')
      if params[:question_text] == ""
        @acerto = false
      else
        @acerto = resposta_aluno[0] == resposta_aluno[1]
      end
      @combinacao_aluno_col1 = resposta_aluno[0]
      @combinacao_aluno_col2 = resposta_aluno[1]

      # if @question.path.level.course.title.downcase == "power link"
      #   pontos = 4
      # else
      #   pontos = 1
      # end
      pontua(@acerto, 20)

    elsif question.type_question == "Questão Aberta"
      # Itera sobre as opcoes de respostas corretas e compara com o que o usuario enviou
      question.question_texts.each do |option|
        resposta = normalize_text(option.student_answer)
        tentativa = normalize_text(resposta_aluno)

        if (resposta == tentativa)
          @acerto = true
        else
          @acerto = false
          resposta = option.student_answer
        end

      end
      # puts "Acertou? "
      # puts acerto
      # puts "resposta "+resposta
      pontua(@acerto, 20)
    elsif question.type_question == "Forca"
      # pega a resposta da questão
      @resposta = normalize_text(@question.question_texts.last.student_answer)

      @forca_finalizada = false


      resposta_array = @resposta.split("")
      tentativa_letra = normalize_text(params[:question_text])

      # exibida no formato _s_s_ na view
      resposta_parcial = params[:forca]
      @forca_tentativas_letras = params[:forca_tentativas_letras]
      @forca_erros = params[:forca_erros].to_i||= 0


      # Adiciona a tentativa Se o array ainda nao tiver a letra
      if @forca_tentativas_letras.include?(tentativa_letra)
          # nao incrementa o contador de erros se ja tiver errado essa letra. Atributo passado para o JS
          @incrementa = false
      else
          @forca_tentativas_letras << tentativa_letra
      end

      # resposta_parcial = resposta_parcial.split("")
      # verifica se a tentativa de letra está no array de respostas, se sim retorna as posicoes
      posicoes = resposta_array.map.with_index{ |s, i| i if s == tentativa_letra }.reject(&:nil?)
      if posicoes.count > 0
          @acerto_forca = true
          # substitui o _ pela letra no array de resposta parcial
          posicoes.each do |p|
              resposta_parcial[p] = tentativa_letra
          end
      end

      @forca = resposta_parcial

      # Verifica se todas as letras foram acertadas(forca finalizada)
      if @forca.scan(/_/).count == 0
        puts "-------------------- Finaliza forca --------------------"
        @forca_finalizada = true
      end
      @acerto = true

      # if (resposta == tentativa)
      #     break
      # else
      #     @acerto = false
      #     @resposta = option.student_answer
      # end

      pontua(@acerto, 20)

    end

    WeeklyChallengeQuiz.create(student_id: current_student.id,
      weekly_challenge_id: @weekly_challenge_id,
      hit: @acerto
    )

  end

  def normalize_text(text)
    normalized = text.mb_chars.normalize
    (normalized.downcase.scan /[^*\!@%\^\s\.,\/()]+/).join(" ").gsub(/[’`´]/, "'")
  end

  def pontua(acerto, pontos)
    if acerto
      student = Student.find(current_student.id)
      student.points += pontos
      student.save
    end
  end

end
