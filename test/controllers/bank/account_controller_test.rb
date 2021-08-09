# frozen_string_literal: true
require 'test_helper'

module Bank
  class AccountControllerTest < ActionDispatch::IntegrationTest
    include IntegrationHelperTest

    def setup
      @account = create(:bank_account).account
    end

    test 'should show account' do
      login(email: @account.email, password: @account.password)
      get bank_account_path
      assert_response :success
    end
  end
end
