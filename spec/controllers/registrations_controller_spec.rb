require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe 'PATCH #update' do
    let(:user) { create(:user) }
    before do
     sign_in user
     request.env['devise.mapping'] = Devise.mappings[:user]
    end

    describe 'when address does not exist' do
      context 'valid data' do
        it 'save address' do
          expect {
            put :address_settings, params: { address: attributes_for(:address,
                                 user_id: user.id, address_type: 'billing') }
          }.to change(Address, :count).by(1)
        end

        it 'redirect to the edit with notice' do
          put :address_settings, params: { address: attributes_for(:address,
                                 user_id: user.id, address_type: 'billing') }
          expect(response).to redirect_to edit_user_registration_path
          expect(flash[:notice]).to be_present
        end
      end

      context 'invalid data' do
        it 'does not save address' do
          expect {
            put :address_settings, params: { address: attributes_for(:address,
                      city: '133', user_id: user.id, address_type: 'billing') }
          }.not_to change(Address, :count)
        end

        it 'renders the :edit template' do
          put :address_settings, params: { address: attributes_for(:address,
                      city: '133', user_id: user.id, address_type: 'billing') }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'when address exist' do
      before { @address = create(:address, user_id: user.id, address_type: 'billing') }

      context 'valid data' do
        before do
          put :address_settings, params: { address: { city: 'Dnipro',
                      user_id: user.id, address_type: 'billing' } }
        end

        it 'update address' do
          @address.reload
          expect(@address.city).to eq('Dnipro')
        end

        it 'redirect to the edit with notice' do
          expect(response).to redirect_to edit_user_registration_path
          expect(flash[:notice]).to be_present
        end
      end

      context 'invalid data' do
        before do
          put :address_settings, params: { address: { city: '123',
                      user_id: user.id, address_type: 'billing' } }
        end

        it 'does not update address' do
          expect(@address.city).to eq('City')
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end
      end
    end
  end
end
