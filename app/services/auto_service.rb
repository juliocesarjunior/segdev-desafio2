class AutoService < ScoreService
  def call
    scores = initial_scores

    if user.vehicle.nil? || user.vehicle.empty?
      scores = 'inelegivel'
    else
      vehicle_year = user.vehicle['year']
      if vehicle_year && Time.now.year - vehicle_year <= 5
        scores += 1
      end
      scores = calculate_score(scores, user)
    end
    scores
  end
end