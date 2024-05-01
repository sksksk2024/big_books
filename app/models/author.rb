class Author < ApplicationRecord
  belongs_to :user

  has_many :books, dependent: :destroy

  before_validation :set_first_name_and_last_name_from_name

  validates :first_name, :last_name, presence: true
  validates :popularity_score, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def set_first_name_and_last_name_from_name
    self.first_name, self.last_name = name.split(' ')

    if self.first_name.nil?
      self.first_name = 'test'
    end

    if self.last_name.nil?
      self.last_name = 'blabla'
    end
  end
end
