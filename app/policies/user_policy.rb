class UserPolicy < ApplicationPolicy

  def show?
    have_permission?
  end

  def index?
    have_permission?
  end

  def edit?
    have_permission?
  end

  def update?
    have_permission?
  end

  def destroy?
    have_permission?
  end

  private

  def have_permission?
    user.admin?
  end

end