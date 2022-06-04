class EventPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def destroy?
    update?
  end

  def show?
    user.present?
  end

  def update?
    user_is_owner?(record)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def user_is_owner?(link)
    user.present? && (link.try(:user) == user)
  end
end
