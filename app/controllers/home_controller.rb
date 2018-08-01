class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]


  def index
    @groups = Group.eager_load(:books)
  end
end
