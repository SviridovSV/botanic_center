require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    before do
      sign_in user
      allow(controller).to receive(:current_user).and_return(user)
    end

    context 'when valid data' do
      it 'saves review' do
        expect{
          post :create, params: { review: attributes_for(:review, book_id: book.id) }
        }.to change(Review, :count).by(1)
      end

      it 'saves review to user' do
        post :create, params: { review: attributes_for(:review, book_id: book.id) }
        expect(user.reviews).not_to be_empty
      end

      it 'redirect to book page with notice' do
        post :create, params: { review: attributes_for(:review, book_id: book.id) }
        expect(response).to redirect_to book
        expect(flash[:notice]).to be_present
      end
    end

    context 'when invalid data' do
      it 'does not save review' do
        expect{
          post :create, params: { review: attributes_for(:review, content: nil,
                                                          book_id: book.id) }
        }.not_to change(Review, :count)
      end

      it 'user reviews should be empty' do
        post :create, params: { review: attributes_for(:review, content: nil,
                                                        book_id: book.id) }
        expect(user.reviews[0]).to be_new_record
      end

      it 'redirect to book page with alert' do
        post :create, params: { review: attributes_for(:review, content: nil,
                                                        book_id: book.id) }
        expect(response).to redirect_to book
        expect(flash[:alert]).to be_present
      end
    end
  end
end
