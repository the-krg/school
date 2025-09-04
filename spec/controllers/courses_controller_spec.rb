require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    let!(:published_course) { Course.create!(external_id: 1, name: 'Math 101', is_published: true) }
    let!(:unpublished_course) { Course.create!(external_id: 2, name: 'History 101', is_published: false) }

    it 'returns a list of published courses' do
      get :index
      expect(assigns(:courses)).to include(published_course)
      expect(assigns(:courses)).not_to include(unpublished_course)
      expect(response).to be_successful
    end
  end
end
