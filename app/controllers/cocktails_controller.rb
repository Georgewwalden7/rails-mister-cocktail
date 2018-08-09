class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.valid?
      @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      @cocktail = Cocktail.new
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id]).delete
    redirect_to cocktails_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :ingredients)
  end

end
