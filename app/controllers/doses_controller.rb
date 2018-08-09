class DosesController < ApplicationController

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @dose.cocktail = @cocktail
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.valid?
      @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
      @dose = Dose.new
    end
  end

  def destroy
    @dose = Dose.find(params[:id]).delete
    redirect_to cocktails_path
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

end
