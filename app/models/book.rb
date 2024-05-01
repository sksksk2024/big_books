# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  belongs_to :author

  validates :page_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999 }
  validates :author, presence: true
end
