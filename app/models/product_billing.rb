# frozen_string_literal: true

class ProductBilling
  def self.purchase(product, user)
    payment_result = Payment.(user.cloud_payments_uid, product.amount_cents, 'RUB', gateway: Payment::Cloud)
    if payment_result.success?
      Delivery.setup(address: user.address, person: user.person_info, weight: product.weight, service: Delivery::Cdek)
      product_access = ProductAccess.create(user: user, product:)
      Notifier.notify(about: product_access, gateway: Notifier::OrderMailer)
    end

    payment_result
  end
end
