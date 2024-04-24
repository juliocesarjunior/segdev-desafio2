module ScoreCalculator
  def calculate_score(scores, user)
    if user.income > 200_000
      scores -= 1
    elsif user.age < 30
      scores -= 2
    elsif user.age >= 30 && user.age <= 40
      scores -= 1
    end
    scores
  end
end