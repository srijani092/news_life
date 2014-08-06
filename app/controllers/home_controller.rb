class HomeController < ApplicationController
  def index
  	@articles = Article.order("dated desc")
  	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end
end
