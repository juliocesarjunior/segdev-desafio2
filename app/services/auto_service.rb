class AutoService < ScoreService
  def call
    scores = initial_scores
    puts "## base score: #{initial_scores}"

    if user.vehicle.nil? || user.vehicle.empty?
      scores = 'inelegivel'
    elsif user.vehicle && user.vehicle['year'] && Time.now.year - user.vehicle['year'] <= 5
      scores += 1
      calculate_score(scores)
      puts "## calculate_score: #{scores}"      
    end
    scores
  end
end