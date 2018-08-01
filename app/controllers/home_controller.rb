class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]


  def index
    @groups = Group.all.with_books
  end
end
