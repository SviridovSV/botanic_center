class ReviewsController < ApplicationController
  def create
    @review= current_user.reviews.build(review_params)
    if @review.save
      redirect_to @review.book, notice: "Thanks for Review. It will be published as soon as Admin will approve it."
    else
      redirect_to @review.book, alert: "Review form contains mistakes."
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :title, :book_id)
  end
end
