class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: calculate_risk(user), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

  def calculate_risk(user)
    base_score = user.risk_questions.sum
    base_score -= 2 if user.age < 30
    base_score -= 1 if user.age >= 30 && user.age <= 40
    base_score -= 1 if user.income > 200_000

    risk_scores = {
      auto: base_score,
      disability: user.income.zero? ? 'ineligible' : base_score,
      home: user.house['ownership_status'] == 'mortgaged' ? base_score + 1 : base_score,
      life: user.age > 60 ? 'ineligible' : (user.marital_status == 'married' ? base_score + 1 : base_score)
    }

    risk_scores.each { |key, value| risk_scores[key] = calculate_risk_category(value) }

    risk_scores
  end

  def calculate_risk_category(score)
    case score
    when 0..-Float::INFINITY then 'economic'
    when 1..2 then 'regular'
    else 'responsible'
    end
  end
end
