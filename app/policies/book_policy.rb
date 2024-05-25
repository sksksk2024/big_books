class BookPolicy < ApplicationPolicy
  def edit?
    user.admin? || user.editor?  # Only admins and editors can edit books
  end

  def show?
    true  # Allow everyone to see a book
  end

  def create?
    user.admin?   # Only admins can create books
  end

  def update?
    user.admin? || user.editor?  # Only admins and editors can update books
  end
end

