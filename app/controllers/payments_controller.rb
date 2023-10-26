class PaymentsController < ApplicationController
  def create
    product = Product.find(params[:product_id])

    if ProductBilling.purchase(product, current_user)
      redirect_to :successful_payment_path
    else
      redirect_to :failed_payment_path, note: 'Что-то пошло не так'
    end
  end
end