# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  belongs_to :author

  validates :page_number, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 999 }
  validates :author, presence: true
  validates :publication_date, presence: true
  validate :publication_date_not_in_future

  private

  def publication_date_not_in_future
    if publication_date && publication_date > Date.current
      errors.add(:publication_date, "cannot be in the future")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["book_name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["author", "user"]
  end

end
