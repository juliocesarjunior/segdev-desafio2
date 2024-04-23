class HomeService < ScoreService
  def call
    scores = initial_scores

    if user.house.nil? || user.house.empty?
      scores = 'inelegivel'
    else
      if user.house && user.house['ownership_status'] == 'rented'
        scores += 1
      end

      if user.marital_status == 'married'
        scores -= 1
      end
      #calculate_score(scores)
    end

    scores
  end
end