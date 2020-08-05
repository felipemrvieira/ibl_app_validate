class Backoffice::CategoriesController < BackofficeController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  has_scope :keyword

  def index
    categories = apply_scopes(Category).all
    @pagy, @categories = pagy(categories, items: 6)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
    @category
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to backoffice_category_path(@category), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: backoffice_category_path(@category) }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to backoffice_category_path(@category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to backoffice_categories_path, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_params
    params.require(:category).permit(:title, :body)
  end

end
