# frozen_string_literal: true
FactoryBot.define do
  factory :account do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'secret' }
  end

  factory :bank_account, class: Bank::Account do
    balance { 100 }
    account
  end

  factory :transaction, class: Bank::Transaction do
    bank_account
    amount { 20 }
    association :output, factory: :bank_account
    trait :same_account do
      after(:build) { |o, values| o.output_id = values.bank_account_id }
    end
  end
end
