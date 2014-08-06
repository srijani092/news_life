class ArticlesController < ApplicationController
before_filter :authorize, :except => [:index, :show]


  def index
  	@category = Category.find(params[:category_id])
  	@articles = @category.articles.order("dated desc")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

 
 

  def show
  	 @category = Category.find(params[:category_id])
  	 @article = @category.articles.find(params[:id])
     respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @article }
    end
  end

  def new
  	@category = Category.find(params[:category_id])


    # Associate an article object with category 1
    @article = @category.articles.build
    respond_to do |format|
      format.html # new.html.erb
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
      format.html { redirect_to category_article_url(@category,@article), notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      # Save the article successfully
      
    else
      format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
    end

  def edit
  	@category = Category.find(params[:category_id])

    # For URL like /categories/1/articles/2/edit
    # Get article id=2 for category 1
    @article = @category.articles.find(params[:id])
  end
  
   def update
    @category = Category.find(params[:category_id])
    @article = Article.find(params[:id])
    respond_to do |format|
    if @article.update_attributes(params[:article])
      format.html { redirect_to category_article_url(@category,@article), notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      # Save the article successfully
      
    else
      format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @category = Category.find(params[:category_id])
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to category_articles_path(@category) }
      format.json { head :no_content }
      format.xml  { head :ok }
    end
  end

end

