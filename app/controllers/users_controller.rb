class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: calculate_insurance_scores(user), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def create_user
       user = User.new(user_params)
      if user.save
        render json: calculate_plans(user), status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end 
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def calculate_plans(user)
    scores = {}

    scores[:auto] = AutoService.new(user).call
    scores[:disability] = DisabilityService.new(user).call
    scores[:home] = HomeService.new(user).call
    scores[:life] = LifeService.new(user).call

    map_scores(scores)
  end


  def map_scores(scores)
    mapped_scores = {}
    scores.each do |key, value|
      case value
      when 'inelegivel'
        mapped_scores[key] = 'inelegivel'
      when -Float::INFINITY..0
        mapped_scores[key] = 'econômico'
      when 1..2
        mapped_scores[key] = 'padrão'
      else
        mapped_scores[key] = 'avancado'
      end
    end

    mapped_scores
  end
end
