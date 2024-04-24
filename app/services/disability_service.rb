class DisabilityService < ScoreService
  def call
    scores = initial_scores

    if user.age > 60 || user.income <= 0
      scores = 'inelegivel'
    else
      if user.house && user.house['ownership_status'] == 'rented'
        scores += 1
      end

      if user.dependents > 0
        scores += 1
      end

      if user.marital_status == 'married'
        scores -= 1
      end
      scores = calculate_score(scores, user)

    end

    scores
  end
end