class WeaponsController < ApplicationController
  def index
    @weapons = Weapon.all
  end

  def show
    @weapon = Weapon.find(params[:id])
  end

  def new
    @weapon = Weapon.new
  end

  def create
    @weapon = Weapon.new(weapon_params)

    if @weapon.save
      redirect_to @weapon
    else
      render 'new'
    end
  end

  def destroy
    @weapon = Weapon.find(params[:id])
    @weapon.destroy

    redirect_to weapons_path
  end

  private

  def weapon_params
    params.require(:weapon).permit(:name, :kind, :power_base, :power_step, :level)
  end
end
