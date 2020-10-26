class Site::QuizzesController < ApplicationController
  layout "site"

  include Pagy::Backend

  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :lista_acertos, only: [:index, :level, :course]
  before_action :set_ranking, only: [:index, :level, :course]
  before_action :contabiliza_pontuacao, only: [:index, :level, :course]
  before_action :enrolled_courses, only: [:index, :level, :course]


  def course
      verifica_conquistas
      course_id = params[:id]
      @course = Course.find(course_id)

      @student_levels = current_student.levels.where(course_id: @course.id)
      @quiz = Quiz.new

      errolments = Errolment.where(student_id: current_student)
      all_courses = []
      errolments.each do |err|
        all_courses << err.level.course
      end
      @courses = all_courses.uniq
  end

  def start_lesson
      @quiz = Quiz.new(quiz_params)

      respond_to do |format|
          # if @quiz.last_quiz_finished?(current_student.id)
              if @quiz.save
                  # sort_and_register_questions(@quiz)
                  format.html { redirect_to site_level_path(@quiz.path.level.id), notice: 'A lição foi iniciada!' }
                  format.json { render :show, status: :created, location: site_level_path(@quiz.path.level.id) }
              else
                  format.html { redirect_to site_quizzes_path, notice: @quiz.errors }
                  format.json { render json: @quiz.errors, status: :unprocessable_entity }
              end
          # else
          #     format.html { redirect_to site_quizzes_path, notice: 'Você precisa finalizar a última lição!' }
          # end

      end
  end

  def report
      @question_error = QuestionError.new
      @question_error.student_id = params[:quiz][:student_id]
      @question_error.question_id = params[:quiz][:question_id]
      @question_error.description = params[:quiz][:description]

      @order = params[:quiz][:order]
      @tipo = params[:quiz][:tipo]

      respond_to do |format|
          if @question_error.save
              format.js
          end
      end
  end

  def level
    id = params[:id]
    @course = Level.find(id).course

    @quiz = Quiz.new
    errolments = Errolment.where(student_id: current_student)
    all_courses = []
    errolments.each do |err|
      all_courses << err.level.course
    end
    @courses = all_courses.uniq

    @level = current_student.levels.find(params[:id])
    @pagy, @paths = pagy(@level.paths.all.order(:id), items: 6)

    @weekly_challenge_question = WeeklyChallenge.last.question
    @weekly_challenge_id = WeeklyChallenge.last.id

    date = WeeklyChallenge.last.exp - Date.today
    @weekly_challenge_exp = date.to_i

    # Valida se o estudante já realizou o último quiz
    if current_student.weekly_challenges.any?
      @show_challenge_button = current_student.weekly_challenges.last.id != WeeklyChallenge.last.id
    else
      @show_challenge_button = true
    end

    # Valida se o estudante já leu a instrução
    if current_student.instructions.any?
      @show_instruction_modal = current_student.instructions.last.id != Instruction.last.id
    else
      @show_instruction_modal = true
      @instruction = Instruction.last
    end
  end

  def index

      verifica_conquistas
      @student_levels = current_student.levels.all
      @courses = Course.all
      @quiz = Quiz.new
  end

  def create
      @quiz = Quiz.new(quiz_params)
      @quiz.id = quiz_params[:id]
      @question = Question.find(@quiz.question_id)
      @attempt = Attempt.new
      @acerto_forca = false
      @forca_finalizada = false
      @incrementa = true


      if @question.type_question == "Múltipla Escolha"
        @acerto = QuestionOption.find(@quiz.question_option_id).correct
        if @question.path.level.course.title.downcase == "power link"
          pontos = 4
        else
          pontos = 1
        end
        pontua(@acerto, pontos)
        opcao = @question.question_options.where(:correct => true).first
        @resposta = opcao.option_description
      elsif @question.type_question == "Combinação"

        # recebe a combinacao, transforma num array e verifica se as posicoes estao corretas
        resposta_aluno = @quiz.question_text.split(':')
        if @quiz.question_text == ""
          @acerto = false
        else
          @acerto = resposta_aluno[0] == resposta_aluno[1]
        end
        @combinacao_aluno_col1 = resposta_aluno[0]
        @combinacao_aluno_col2 = resposta_aluno[1]

        if @question.path.level.course.title.downcase == "power link"
          pontos = 4
        else
          pontos = 1
        end
        pontua(@acerto, pontos)

      elsif @question.type_question == "Questão Aberta"
        # Itera sobre as opcoes de respostas corretas e compara com o que o usuario enviou
        @question.question_texts.each do |option|
          resposta = normalize_text(option.student_answer)
          tentativa = normalize_text(@quiz.question_text)

          if (resposta == tentativa)
            @acerto = true

            if @question.path.level.course.title.downcase == "power link"
              pontos = 4
            else
              pontos = 1
            end
            pontua(@acerto, pontos)
            break
          else
            @acerto = false
            @resposta = option.student_answer
          end
        end
      elsif @question.type_question == "Forca"
          # pega a resposta da questão
          @resposta = normalize_text(@question.question_texts.last.student_answer)

          resposta_array = @resposta.split("")
          tentativa_letra = normalize_text(@quiz.question_text)

          # exibida no formato _s_s_ na view
          resposta_parcial = params[:quiz][:forca]
          @forca_tentativas_letras = params[:quiz][:forca_tentativas_letras]

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
              @forca_finalizada = true

              if @question.path.level.course.title.downcase == "power link"
                pontos = 4
              else
                pontos = 1
              end
              pontua(@acerto, pontos)
          end
          @acerto = true

          # if (resposta == tentativa)
          #     break
          # else
          #     @acerto = false
          #     @resposta = option.student_answer
          # end

      end


      @attempt.hit = @acerto
      @attempt.student_id = current_student.id
      @attempt.question_id = params[:quiz][:question_id]
      @order = params[:quiz][:order]
      @type = params[:quiz][:type]
      @forca_erros = params[:quiz][:forca_erros].to_i ||= 0



      # if @type == "praticar" && @acerto
      if @type == "praticar"
          student = Student.find(current_student.id)
          if student.pratice_points == nil
              student.pratice_points = 1
          else
              student.pratice_points += 1
          end
          student.save
      end

      respond_to do |format|
          if @attempt.save
              # format.html { redirect_to @quiz, notice: 'Question was successfully created.' }
              format.js
              # format.json { render :show, status: :created, location: @quiz }

          else
              # byebug
              format.html { render :new }
              format.json { render json: @quiz.errors, status: :unprocessable_entity }
          end
      end
  end


  def updatesds
      @quiz = Quiz.new(quiz_params)
      question = Question.find(@quiz.question_id)

      if question.type_question == "Múltipla Escolha"
          @acerto = @quiz.question_option.correct
      elsif question.type_question == "Questão Aberta"
          question.question_texts.each do |option|
              if option.student_answer == @quiz.question_text
                  @acerto = true
                  break
              else
                  @acerto = false
              end
          end
      end

      respond_to do |format|
          if @quiz.save
              # format.html { redirect_to @quiz, notice: 'Question was successfully created.' }
              format.js
              # format.json { render :show, status: :created, location: @quiz }

          else
              # byebug
              format.html { render :new }
              format.json { render json: @quiz.errors, status: :unprocessable_entity }
          end
      end
  end
  private
      # Use callbacks to share common setup or constraints between actions.
      def set_question
          @question = Question.find(params[:id])
      end

      def enrolled_courses
        errolments = Errolment.where(student_id: current_student)
        all_courses = []
        errolments.each do |err|
          all_courses << err.level.course
        end
        @enrolled_courses = all_courses.uniq
      end

      # torna a reposta downcase, exclui caracteres especiais(gerando um array) junta o array
      def normalize_text(text)
          normalized = text.mb_chars.normalize
          (normalized.downcase.scan /[^*\!@%\^\s\.,\/()]+/).join(" ").gsub(/[’`´]/, "'")
      end

      def set_ranking
          @greatest_students_br = Student.order("points DESC").first(5)
          @greatest_students_unit = current_student.unit.students.order("points DESC").first(5)
      end

      def contabiliza_pontuacao
          @licoes = current_student.quizzes.count
          @questoes = Attempt.where(:student_id => current_student.id).count
          @pontos = current_student.points
      end

      def verifica_conquistas
          verifica_conquistas_leao
          verifica_conquistas_canguru
          verifica_conquistas_aguia
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def quiz_params
          params.require(:quiz).permit(
            :id,
            :student_id,
            :path_id,
            :question_id,
            :question_option_id,
            :question_text,
            :questao_combinar
          )
      end

      def lista_acertos
        @acertos_semanais = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-7).beginning_of_day, (Date.today).end_of_day+3.hours)
        @acertos_hoje = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today).beginning_of_day, (Date.today).end_of_day).count
        @acertos_1_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-1.day).beginning_of_day, (Date.today-1.day).end_of_day).count
        @acertos_2_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-2.day).beginning_of_day, (Date.today-2.day).end_of_day).count
        @acertos_3_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-3.day).beginning_of_day, (Date.today-3.day).end_of_day).count
        @acertos_4_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-4.day).beginning_of_day, (Date.today-4.day).end_of_day).count
        @acertos_5_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-5.day).beginning_of_day, (Date.today-5.day).end_of_day).count
        @acertos_6_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-6.day).beginning_of_day, (Date.today-6.day).end_of_day).count
        @acertos_7_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-7.day).beginning_of_day, (Date.today-7.day).end_of_day).count
        @acertos_8_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-8.day).beginning_of_day, (Date.today-8.day).end_of_day).count
        @acertos_9_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-9.day).beginning_of_day, (Date.today-9.day).end_of_day).count
        @acertos_10_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-10.day).beginning_of_day, (Date.today-10.day).end_of_day).count
        @acertos_11_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-11.day).beginning_of_day, (Date.today-11.day).end_of_day).count
        @acertos_12_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-12.day).beginning_of_day, (Date.today-12.day).end_of_day).count
        @acertos_13_dia_atras = Attempt.where("student_id = ? AND hit = ? AND created_at BETWEEN ? AND ?", current_student.id, true, (Date.today-13.day).beginning_of_day, (Date.today-13.day).end_of_day).count
      end

      def sort_and_register_questions(quiz)
        path = Path.find(quiz.path_id)
        questions = path.questions
        order = 1
        questions.each do |question|
          qq = QuizQuestion.new
          qq.question_id = question.id
          qq.quiz_id = quiz.id
          qq.order = order
          order += 1
          qq.save
        end
      end

      def pontua(acerto, pontos)
        if acerto
          student = Student.find(current_student.id)
          student.points += pontos
          student.save
        end
      end

      def verifica_conquistas_leao

          if current_student.count_day_logins >= 10
              unless current_student.achievements.where(description: "Garras de Leão Bronze").any?
                  current_student.achievements << Achievement.where(description: "Garras de Leão Bronze")
                  current_student.save!
              end
          end

          if current_student.count_day_logins >= 50
              unless current_student.achievements.where(description: "Garras de Leão Prata").any?
                  current_student.achievements << Achievement.where(description: "Garras de Leão Prata")
                  current_student.save!
              end
          end

          if current_student.count_day_logins >= 100
              unless current_student.achievements.where(description: "Garras de Leão Ouro").any?
                  current_student.achievements << Achievement.where(description: "Garras de Leão Ouro")
                  current_student.save!
              end
          end

          if current_student.count_day_logins >= 150
              unless current_student.achievements.where(description: "Garras de Leão Platina").any?
                  current_student.achievements << Achievement.where(description: "Garras de Leão Platina")
                  current_student.save!
              end
          end

      end

      def verifica_conquistas_aguia
          if current_student.pratice_points != nil

              if current_student.pratice_points >= 100
                  unless current_student.achievements.where(description: "Olhos de Águia Bronze").any?
                      current_student.achievements << Achievement.where(description: "Olhos de Águia Bronze")
                      current_student.save!
                  end
              end

              if current_student.pratice_points >= 500
                  unless current_student.achievements.where(description: "Olhos de Águia Prata").any?
                      current_student.achievements << Achievement.where(description: "Olhos de Águia Prata")
                      current_student.save!
                  end
              end

              if current_student.pratice_points >= 1000
                  unless current_student.achievements.where(description: "Olhos de Águia Ouro").any?
                      current_student.achievements << Achievement.where(description: "Olhos de Águia Ouro")
                      current_student.save!
                  end
              end

              if current_student.pratice_points >= 2000
                  unless current_student.achievements.where(description: "Olhos de Águia Platina").any?
                      current_student.achievements << Achievement.where(description: "Olhos de Águia Platina")
                      current_student.save!
                  end
              end

          end

      end

      def verifica_conquistas_canguru

          # quizzes_finalizados = current_student.quizzes_finished

          # if quizzes_finalizados >= 10
          #     unless current_student.achievements.where(description: "Canguru Supremo Bronze").any?
          #         current_student.achievements << Achievement.where(description: "Canguru Supremo Bronze")
          #         current_student.save!
          #     end
          # end

          # if quizzes_finalizados >= 50
          #     unless current_student.achievements.where(description: "Canguru Supremo Prata").any?
          #         current_student.achievements << Achievement.where(description: "Canguru Supremo Prata")
          #         current_student.save!
          #     end
          # end

          # if quizzes_finalizados >= 100
          #     unless current_student.achievements.where(description: "Canguru Supremo Ouro").any?
          #         current_student.achievements << Achievement.where(description: "Canguru Supremo Ouro")
          #         current_student.save!
          #     end
          # end

          # if quizzes_finalizados >= 200
          #     unless current_student.achievements.where(description: "Canguru Supremo Platina").any?
          #         current_student.achievements << Achievement.where(description: "Canguru Supremo Platina")
          #         current_student.save!
          #     end
          # end

          if current_student.points >= 100
              unless current_student.achievements.where(description: "Canguru Supremo Bronze").any?
                  current_student.achievements << Achievement.where(description: "Canguru Supremo Bronze")
                  current_student.save!
              end
          end

          if current_student.points >= 500
              unless current_student.achievements.where(description: "Canguru Supremo Prata").any?
                  current_student.achievements << Achievement.where(description: "Canguru Supremo Prata")
                  current_student.save!
              end
          end

          if current_student.points >= 1000
              unless current_student.achievements.where(description: "Canguru Supremo Ouro").any?
                  current_student.achievements << Achievement.where(description: "Canguru Supremo Ouro")
                  current_student.save!
              end
          end

          if current_student.points >= 2000
              unless current_student.achievements.where(description: "Canguru Supremo Platina").any?
                  current_student.achievements << Achievement.where(description: "Canguru Supremo Platina")
                  current_student.save!
              end
          end
      end

end
