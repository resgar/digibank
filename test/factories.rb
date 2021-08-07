FactoryBot.define do
  factory :account do
    email { 'user@example.com' }
    password { 'secret' }
  end

  factory :bank_account, class: Bank::Account do
    balance { 100 }
    account

    trait :output do
      association :account, email: 'another@example.com'
    end
  end

  factory :transaction, class: Bank::Transaction do
    bank_account
    amount { 20 }
    association :output, :output, factory: :bank_account
  end
end
