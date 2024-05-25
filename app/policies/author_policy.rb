class AuthorPolicy < ApplicationPolicy
  def edit?
    user.admin? || user.editor?  # Only admins and editors can edit authors
  end
  
  def show?
    true  # Allow everyone to see an author
  end

  def create?
    user.admin? || user.editor?  # Only admins and editors can create authors
  end

  def update?
    user.admin? || user.editor?  # Only admins and editors can update authors
  end

  def destroy?
    user.admin?  # Only admins can delete authors
  end
end
