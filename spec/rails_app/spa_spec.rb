require 'rails_helper'

feature 'hello world' do
  before :all do
    Reactify::Specs::Generators.run_npm_generator
  end

  scenario 'Seeing the basic javascript render', :js do
    when_i_visit_the_spa
    then_i_should_see_hello_world
    and_i_should_see_the_data_from_the_redux_store
  end

  def when_i_visit_the_spa
    visit '/spa'
  end

  def then_i_should_see_hello_world
    expect(page).to have_content 'Hello world'
  end

  def and_i_should_see_the_data_from_the_redux_store
    expect(page).to have_content 'This text is set as an instance variable'
  end
end
