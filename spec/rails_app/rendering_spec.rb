require 'rails_helper'

describe HomeController, type: :controller do
  it 'renders the SPA when there is no template present' do
    get :spa
    expect(response).to render_template('reactify/spa')
  end

  it 'renders the template in the Rails /app/views directory if present' do
    get :front_page
    expect(response).to render_template('home/front_page')
  end

  context 'with the view rendered' do
    render_views

    it 'adds the controller variables to the javascript' do
      get :spa
      expect(response.body).to include('"test_var":123')
    end
  end
end
