class LifeService < ScoreService
  def call
    scores = initial_scores

    if user.dependents > 0
      scores += 1
    end

    if user.marital_status == 'married'
      scores += 1
    end

    if user.age > 60 || user.income <= 0
      scores = 'inelegivel'
    elsif user.age < 30
      scores -= 2
    elsif user.age >= 30 && user.age <= 40
      scores -= 1
    end

    scores
  end
end