class Api::PostsController < BackofficeController

    def index
      @posts = Post.all.reverse_order
      render json: @posts, :include => :categories
    end

    def show
      @post = Post.friendly.find(params[:id])
      render json: @post, :include => :categories
    end

    def search
      @posts = Post.search_by_term(params[:query])
      render json: @posts, :include => :categories
    end

    def categories
      @categories = Category.all.reverse_order
      render json: @categories
    end

    def categories_show
      @category = Category.friendly.find(params[:id])
      render json: @category, :include => :posts
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end

end
