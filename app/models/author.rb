class Author < ApplicationRecord
  validates :first_name, :last_name, presence: true
  validates :popularity_score, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_nil: true
  has_many :books, dependent: :destroy
  belongs_to :user
  before_validation :set_name_from_full_name_before_validation, on: [:create, :update]

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_name_from_full_name_before_validation
    set_name_from_full_name
  end

  def set_name_from_full_name
    puts "Setting name from full name"
    self.name = "#{first_name} #{last_name}"
  end
end
