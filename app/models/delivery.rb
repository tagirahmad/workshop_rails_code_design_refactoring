# frozen_string_literal: true

module Delivery

  def setup(address:, person:, weight:, service:)
    setup_result = service.setup_delivery(address:, person:, weight:)

    if setup_result
      Notifier.notify(about: setup_result, gateway: Notifier::Sms)
    else
      Notifier.notify(about: "#{service.to_s.upcase} service doesnt work!!!", gateway: Notifier::Sms)
    end
  end

  class Service
    def setup_delivery(address:, person:, weight:)
      raise NoMethodError 'You have to implement it by your own'
    end
  end

  class Cdek < Service
    def setup_delivery(address:, person:, weight:)
      Shipping.create!(address:, person:, weight:) == { result: 'succeed' } ? true : false
    end
  end

  class Dhl < Service
    def setup_delivery(address:, person:, weight:)
      # eventually returns true or false
    end
  end
end
