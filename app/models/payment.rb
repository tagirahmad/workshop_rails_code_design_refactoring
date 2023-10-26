# frozen_string_literal: true

module Payment
  def call(user_id, amount, currency, gateway:)
    gateway.proccess(
      user_uid: user_id,
      amount: amount,
      currency: currency
    )
  end

  class Cloud
    def self.proccess(user_uid:, amount:, currency:)
      CloudPayment.proccess(
        user_uid: user_uid,
        amount_cents: amount * 100,
        currency: currency
      )
    end
  end
end
