class ScoreService
	include ScoreCalculator

	attr_reader :user

	def initialize(user)
		@user = user
	end

	private
	def initial_scores
		user.risk_questions.sum
	end
end