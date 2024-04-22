class AutoService
  def initialize(user)
    @user = user
  end

  def call
    initial_scores = @user.risk_questions.sum
    score = initial_scores
    score += 1 if @user.vehicle && Time.now.year - @user.vehicle['year'] <= 5

    score = 'ineligible' if @user.vehicle.nil? || @user.vehicle.empty?

    score # Return the score directly
  end
end