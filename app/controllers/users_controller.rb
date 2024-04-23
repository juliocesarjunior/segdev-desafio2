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
    scores[:home] = HomeService.new(user).call

    #map_scores(scores)
    scores
  end

  def calculate_insurance_scores(user)
    initial_scores = user.risk_questions.sum

    scores = {
      auto: initial_scores,
      disability: initial_scores,
      home: initial_scores,
      life: initial_scores
    }

    puts scores

    if user.house && user.house['ownership_status'] == 'rented'
      scores[:home] += 1
      scores[:disability] += 1
      puts "## 1: #{scores}"
    end

    if user.dependents > 0
      scores[:life] += 1
      scores[:disability] += 1
      puts "## 2: #{scores}"
    end

    if user.marital_status == 'married'
      scores[:life] += 1
      scores[:disability] -= 1
      puts "## 3: #{scores}"
    end

    if user.vehicle && user.vehicle['year'] && Time.now.year - user.vehicle['year'] <= 5
      scores[:auto] += 1
      puts "## 4: #{scores}"
    end

    if user.income > 200_000
      scores.each_key { |key| scores[key] -= 1 }
      puts "## 5: #{scores}"
    elsif user.age < 30
      scores.each_key { |key| scores[key] -= 2 }
      puts "## 6: #{scores}"
    elsif user.age >= 30 && user.age <= 40
      scores.each_key { |key| scores[key] -= 1 }
      puts "## 6: #{scores}"
    end

    if user.age > 60
      scores[:disability] = 'inelegivel'
      scores[:life] = 'inelegivel'
    end

    if user.income <= 0
      scores[:disability] = 'inelegivel'
    end

    if user.vehicle.nil? || user.vehicle.empty?
      scores[:auto] = 'inelegivel'
    end

    if user.house.nil? || user.house.empty?
      scores[:home] = 'inelegivel'
    end

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
