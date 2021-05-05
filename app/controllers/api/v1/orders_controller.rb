module Api
  module V1
    class OrdersController < ApplicationController
      def revenue_per_country
        revenue = Order.where(country_id: params[:country]).sum(:total_price)

        if revenue.zero? && params[:country] != "undefined"
          revenue = Order.all.sum(:total_price)
        end

        render json: {revenue: revenue}
      end

      def average_revenue_per_country
        average_revenue = Order.where(country_id: params[:country]).average(:total_price)
        
        if average_revenue.nil? && params[:country] != "undefined"
          average_revenue = Order.all.average(:total_price)
        end
        
        render json: {average_revenue: average_revenue}
      end

      def revenue_per_month
        orders = Order.where(country_id: params[:country])

        if orders.empty? && params[:country] != "undefined"
          orders = Order.all
        end

        revenue_per_month = {}
        orders.each do |order|
          if revenue_per_month[[order.date.month, order.date.year]]
            revenue_per_month[[order.date.month, order.date.year]] += order.total_price
          else
            revenue_per_month[[order.date.month, order.date.year]] = order.total_price
          end
        end

        render json: {revenue_per_month: revenue_per_month}
      end
    end
  end
end
