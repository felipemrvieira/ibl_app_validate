class Backoffice::StudentBooksController < BackofficeController
  before_action :set_student_book, only: [:show, :edit, :update, :destroy]

  def index
    @student_books = StudentBook.all
  end

  def show
  end

  def new
    @student_book = StudentBook.new
  end

  def edit
  end

  def create
    @student_book = StudentBook.new(student_book_params)
    authorize @student_book

    respond_to do |format|
      if @student_book.save
        format.html { redirect_to request.referer, notice: 'O livro do estudante foi adicionado.' }
        format.json { render :show, status: :created, location: @student_book }
      else
        format.html { redirect_to request.referer, notice: student_book_params.respond_to?(:student_id) ? 'O estudante já possui esse livro.' : 'Usuário deve ser cadastrado para adicionar livros.' }
        format.json { render json: @student_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student_book.update(student_book_params)
        format.html { redirect_to backoffice_student_path, notice: 'Student book was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_book }
      else
        format.html { render :edit }
        format.json { render json: @student_book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student_book.destroy
    respond_to do |format|
      format.html { redirect_to request.referer, notice: 'O livro do estudante foi deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_book
      @student_book = StudentBook.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_book_params
      params.permit(:book_id, :student_id)
    end
end
