class Backoffice::BooksController < BackofficeController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    authorize @book
  end

  def edit
    @book_options = Book.all
    authorize @book
  end

  def create
    @book = Book.new(book_params)
    authorize @book

    respond_to do |format|
      if @book.save
          format.html { redirect_to new_backoffice_book_path, notice: "O livro #{@book.course_level_book} foi adicionado." }
          format.json { render :show, status: :created, location: new_backoffice_book_path }
      else
          format.html { render :new }
          format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @book
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'O livro foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @book
    @book.destroy
    redirect_to new_backoffice_book_path, notice:  "O livro #{@book.course_level_book} foi deletado."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :level_id, :attachment, :cover, :downloadable)
    end
end
