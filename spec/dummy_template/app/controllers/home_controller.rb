class HomeController < ApplicationController
  # This route has no template, so the SPA should render.
  def spa
    @test_var = 123
    @message = 'This text is set as an instance variable in the '\
               'home_controller#spa controller action. It is passed into the '\
               'Redux store automatically.'

  end

  # This has a template, so the SPA should be ignored.
  def front_page

  end
end
