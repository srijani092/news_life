class Api::V1::CategoriesController < ApplicationController
	def index
		@categories = Category.all

    respond_to do |format|
   
      format.json { render json: @categories }
    end
  end


  def show
    @category = Category.find(params[:id])

    respond_to do |format|
    
      format.json { render json: @category }
    end
  end


  def new
    @category = Category.new

    respond_to do |format|
    
      format.json { render json: @category }
    end
  end


  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
      
        format.json { render json: @category, status: :created, location: @category }
      else
      
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
       
        format.json { head :no_content }
      else
       
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  
   def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
     
      format.json { head :no_content }
    end
  end


end
