ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  module IntegrationHelperTest
    def login(email: 'user@example.com', password: 'secret')
      post '/login', as: :json, params: { login: email, password: password }
    end

    def logout
      post '/logout',
           as: :json,
           headers: {
             'Authorization' => headers['Authorization'],
           }
    end
  end
end
