class Order < ApplicationRecord
  has_many :sales
  belongs_to :customer
  belongs_to :country
  belongs_to :customer
end
