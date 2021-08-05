require 'test_helper'

module Bank
  class AccountControllerTest < ActionDispatch::IntegrationTest
    include IntegrationHelperTest

    def setup
      @user = ::Account.create(email: 'account@example.com', password: 'secret')
    end

    test 'should show account' do
      login(email: 'account@example.com', password: 'secret')
      get bank_account_path
      assert_response :success
    end
  end
end
