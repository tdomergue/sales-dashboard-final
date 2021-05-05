class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :country
  belongs_to :customer
end
