class Backoffice::PostsController < BackofficeController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    has_scope :keyword

    def index
        posts = apply_scopes(Post).all
        @pagy, @posts = pagy(posts, items: 6)
    end

    def show
    end

    def new
      @post = Post.new
      @categories = Category.all

    end

    def edit
      @post
      @categories = Category.all

    end

    def create
        @post = Post.new(post_params)

        respond_to do |format|
            if @post.save
              format.html { redirect_to backoffice_post_path(@post), notice: 'Post was successfully created.' }
              format.json { render :show, status: :created, location: backoffice_post_path(@post) }
            else
              format.html { render :new }
              format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

  def update
    respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to backoffice_post_path(@post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
    end
  end

    def destroy
        @post.destroy
        respond_to do |format|
          format.html { redirect_to backoffice_posts_path, notice: 'Post was successfully destroyed.' }
          format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(
        :title,
        :body,
        :image,
        post_categories_attributes: [:id, :category_id, :_destroy]
      )

    end

end
