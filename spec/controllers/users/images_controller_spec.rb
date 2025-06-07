RSpec.describe Users::ImagesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before do
    auth_as user
  end

  describe 'GET #index' do
    before do
      user.images.attach(io: File.open("#{Rails.root}/spec/fixtures/users/sample-dp-6.webp"), filename: 'sample-dp-6.webp', content_type: 'image/webp')
    end
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['images']).to be_an(Array)
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        file: fixture_file_upload('spec/fixtures/users/sample-dp-6.webp', 'image/webp')
      }
    end

    it 'creates a new image' do
      expect(user.images.count).to eq(0)
      expect {
        post :create, params: valid_params
      }.to change(ActiveStorage::Attachment, :count).by(1)
      expect(response).to have_http_status(:ok)
      expect(user.images.count).to eq(1)
    end
  end

  describe 'DELETE #destroy' do
    before do
      user.images.attach(io: File.open("#{Rails.root}/spec/fixtures/users/sample-dp-6.webp"), filename: 'sample-dp-6.webp', content_type: 'image/webp')
    end

    it 'deletes the image' do
      expect(user.images_attachments.count).to eq(1)
      expect {
        delete :destroy, params: { id: user.images_attachments.first.id }
      }.to change(ActiveStorage::Attachment, :count).by(-1)
      expect(response).to have_http_status(:ok)
      expect(user.images_attachments.count).to eq(0)
    end
  end
end
