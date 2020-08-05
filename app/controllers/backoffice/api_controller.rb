class Backoffice::ApiController < BackofficeController
  def posts
    @posts = Post.all.reverse_order
    render json: @posts, :include => :categories
  end


end
