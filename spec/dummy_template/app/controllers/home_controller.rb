class HomeController < ApplicationController
  # This route has no template, so the SPA should render.
  def spa
    @test_var = 123
  end

  # This has a template, so the SPA should be ignored.
  def front_page

  end
end
