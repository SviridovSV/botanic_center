class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to @review.book, notice: I18n.t('flash.review_created')
    else
      redirect_to @review.book, alert: I18n.t('flash.review_failed')
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :title, :book_id)
  end
end
