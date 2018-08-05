class GroupPolicy < ApplicationPolicy

  def new?
    have_permission?
  end

  def create?
    have_permission?
  end

  def show?
    user.present?
  end

  def index?
    user.present?
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
    user.group_editor? || user.admin?
  end

end