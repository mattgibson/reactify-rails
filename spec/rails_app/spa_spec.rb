require 'rails_helper'

feature 'hello world' do
  before :all do
    Reactify::Specs::Generators.run_npm_generator
  end

  scenario 'Seeing the basic javascript render', :js do
    when_i_visit_the_spa
    then_i_should_see_hello_world
  end

  def when_i_visit_the_spa
    visit '/index'
  end

  def then_i_should_see_hello_world
    expect(page).to have_content 'Hello world'
  end
end
