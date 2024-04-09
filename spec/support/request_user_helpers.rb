module RequestUserHelpers
	def self.risk_example
		{
			'application/json' => {
				auto: 'econômico',
				disability: 'inelegivel',
				home: 'econômico',
				life: 'padrão'
			}
		}
	end
	def self.risk_params_parameter(overrides = {})
		{
			name: :user_params, in: :body, schema: {
				type: :object,
				properties: {
					age: { type: :integer, example: 35 },
					dependents: { type: :integer, example: 2 },
					house: {
						type: :object,
						properties: {
							ownership_status: { type: :string, example: 'owned', enum: ['owned', 'rented'] }
						},
						required: [:ownership_status]
					},
					income: { type: :integer, example: 0 },
					marital_status: { type: :string, example: 'married', enum: ['single', 'married'] },
					risk_questions: { type: :array, items: { type: :integer }, example: [0, 1, 0] },
					vehicle: {
						type: :object,
						properties: {
							year: { type: :integer, example: 2018 }
						}
					}
				},
				required: [:age, :dependents, :house, :income, :marital_status, :risk_questions, :vehicle]
			}.merge(overrides)
		}
	end
end