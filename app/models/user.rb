# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :admin_password, :editor_password
  enum role: { user: 0, admin: 1, editor: 2 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :authors

  before_create :set_role  # Ensure this callback is called before creating the user
  after_create :enqueue_welcome_email
  after_save :clear_cache

  private

  def set_role
    if admin_password.present? && admin_password == ENV['ADMIN_PASSWORD']
      self.role = :admin
    elsif editor_password.present? && editor_password == ENV['EDITOR_PASSWORD']
      self.role = :editor
    else
      self.role = :user
    end
  end

  def enqueue_welcome_email
    MyBackgroundJob.perform_later(self.id)
  end

  def clear_cache
    Rails.cache.delete(["user_cache", self])
  end
end
