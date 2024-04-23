class ScoreService
	attr_reader :user

	def initialize(user)
		@user = user
	end

	def calculate_score(scores)
		if user.income > 200_000
			scores -= 1
		elsif user.age < 30
			scores -= 2
		elsif user.age >= 30 && user.age <= 40
			scores -= 1
		end
		scores
	end

	private
	def initial_scores
		user.risk_questions.sum
	end
end