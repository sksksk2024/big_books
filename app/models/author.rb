class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :popularity_score, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_nil: true
  has_many :books, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end
