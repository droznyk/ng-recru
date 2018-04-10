class CommentsController < ApplicationController
  def create
    movie = Movie.find(params[:movie_id])
    @comment = movie.comments.new(comment_params)
    if current_user.comments.find_by(movie_id: params[:movie_id])
      comment_already_exists
    elsif @comment.save
      flash[:notice] = 'Comment has been added successfully'
      redirect_to movie_path(params[:movie_id])
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    flash[:notice] = 'Comment has been deleted'
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to movies_path
    else
      flash[:error] = "This is not your comment!"
    redirect_back(fallback_location: movies_path)
    end
  end

  def top_commenters
    commenters_array = Comment.top_10_commenters_last_week
    users = User.all
    @top_commenters = []
    commenters_array.each { |key, value| @top_commenters << users[key-1] }
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end

  def comment_already_exists
    flash[:error] = "You've already commented this film"
    redirect_back(fallback_location: movies_path)
  end
end
