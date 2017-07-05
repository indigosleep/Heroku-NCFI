class Order < ApplicationRecord
  has_many :line_items
  accepts_nested_attributes_for :line_items, reject_if: :all_blank

  alias_attribute :id, :shopifyID

  has_many :shipping_addresses
  # accepts_nested_attributes_for :shipping_address

  has_many :fulfillments
  accepts_nested_attributes_for :fulfillments
end
