class LifeService < ScoreService
  def call
    scores = initial_scores
    if user.age > 60
      scores = 'inelegivel'
    else
      if user.dependents > 0
        scores += 1
      end

      if user.marital_status == 'married'
        scores += 1
      end
      scores = calculate_score(scores, user)
    end

    scores
  end
end