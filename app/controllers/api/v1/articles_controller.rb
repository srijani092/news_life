class Api::V1::ArticlesController < ApplicationController
	def index
  	@category = Category.find(params[:category_id])
  	@articles = @category.articles.order("dated desc")
    article_response = []

    @articles.each do |article|
    article_response <<   {
        :headline => article.headline,
        :article_id => article.id, 
        :dated => article.dated,
        :desc => article.content,
        :photo_url =>  'http://' + request.host_with_port.to_s + article.photo.url.to_s
      }
    end
    
    render json: article_response
  end

   def show
  	 @category = Category.find(params[:category_id])
  	 @article = @category.articles.find(params[:id])
     article_response = {
      :article_id => @article.id,
      :headline => @article.headline,
      :dated => @article.dated,
      :desc => @article.content,
      :photo_url =>  'http://' + request.host_with_port.to_s + @article.photo.url.to_s
     }

     render json: article_response
  end


  def new
  	@category = Category.find(params[:category_id])


    # Associate an article object with category 1
    @article = @category.articles.build
    respond_to do |format|
     
      format.json { render json: @article }
    end
  end



  def create

    @category = Category.find(params[:category_id])

    # For URL like /categories/1/articles
    # Populate an article associate with category 1 with form data
    # Category will be associated with the article
    @article = @category.articles.build(params[:article])
    respond_to do |format|
    if @article.save
     
        format.json { render json: @article, status: :created, location: @article }
      # Save the article successfully
      
    else
     
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @article = Article.find(params[:id])
    respond_to do |format|
    if @article.update_attributes(params[:article])
     
        format.json { head :no_content }
      # Save the article successfully
      
    else
      
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


def destroy
    @category = Category.find(params[:category_id])
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
     
      format.json { head :no_content }
     
    end
  end


end



