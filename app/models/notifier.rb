# frozen_string_literal: true

module Notifier
  def notify(about:, gateway:)
    gateway.new.notify(about: about)
  end

  class Gateway
    def notify(about:)
      raise NoMethodError 'You have to implement it by your own'
    end
  end

  class OrderMailer < Gateway
    def notify(about:)
      if about.is_a? ProductAccess
        OrderMailer.product_access_email(about).deliver_later
      end
    end

    class Sms < Gateway
      def notify(about:)

      end
    end
  end
end
