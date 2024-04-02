class RiskScoreController < ApplicationController
	def calculate_score
		data = JSON.parse(request.body.read)
		insurance_scores = calculate_insurance_scores(data)
		render json: insurance_scores
	end

	private

	def calculate_insurance_scores(data)
		scores = {
			life: 0,
			disability: 0,
			home: 0,
			auto: 0
		}


		if data['house']['ownership_status'] == 'rented'
			scores[:home] += 1
			scores[:disability] += 1
			puts "## 1: #{scores}"
		end

		if data['dependents'] > 0
			scores[:life] += 1
			scores[:disability] += 1
			puts "## 2: #{scores}"
		end

		if data['marital_status'] == 'married'
			scores[:life] += 1
			scores[:disability] -= 1
			puts "## 3: #{scores}"
		end

		if Time.now.year - data['vehicle']['year'] <= 5
			scores[:auto] += 1
			puts "## 4: #{scores}"
		end

		if data['income'] > 200_000
			scores.each_key { |key| scores[key] -= 1 }
			puts "## 5: #{scores}"
		elsif data['age'] < 30
			scores.each_key { |key| scores[key] -= 2 }
			puts "## 6: #{scores}"
		elsif data['age'] >= 30 && data['age'] <= 40
			scores.each_key { |key| scores[key] -= 1 }
			puts "## 6: #{scores}"
		end

		if data['age'] > 60
			scores[:disability] = 'inelegivel'
			scores[:life] = 'inelegivel'
			return scores
		end
    # scores[:home] += 1 if data['house']['ownership_status'] == 'rented'
    # scores[:disability] += 1 if data['dependents'] > 0
    # scores[:life] += 1 if data['marital_status'] == 'married'
    # scores[:auto] += 1 if Time.now.year - data['vehicle']['year'] <= 5

    # scores.each_key do |key|
    #   case scores[key]
    #   when 0 then scores[key] = 'economico'
    #   when 1..2 then scores[key] = 'padrao'
    #   else scores[key] = 'avancado'
    #   end
    # end

    scores
end
end
