require 'rails_helper'

describe HomeController, type: :controller do
  it 'renders the SPA when there is no template present' do
    get :index
    expect(response).to render_template('reactify_spa')
  end

  it 'renders the template in the Rails /app/views directory if present' do
    get :front_page
    expect(response).to render_template('home/front_page')
  end
end
