require 'swagger_helper'
require 'factory_bot_rails'


RSpec.describe "/calculate", type: :request do
  path '/calculate' do
    post('calculate') do
      tags 'Calculate Score'
      consumes 'application/json'
      produces 'application/json'

      parameter RequestUserHelpers.risk_params_parameter

      response(200, 'successful') do
        examples RequestUserHelpers.risk_example
        run_test!
      end

    end
  end

end
