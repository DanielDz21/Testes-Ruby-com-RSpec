class EnemiesController < ApplicationController
  before_action :set_enemy, only: %i[update destroy show]

  def index
    @enemies = Enemy.all
    render json: @enemies, status: :ok
  end

  def show
    render json: @enemy, status: :ok
  end

  def create
    @enemy = Enemy.new(enemy_params)
    if @enemy.save
      render json: @enemy, status: :created
    else
      render json: @enemy.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @enemy.update(enemy_params)
      render json: @enemy, status: :ok
    else
      render json: { errors: @enemy.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @enemy.destroy
    head :no_content
  end

  private

  def enemy_params
    params.permit(:name, :kind, :power_base, :power_step, :level)
  end

  def set_enemy
    @enemy = Enemy.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end
end
