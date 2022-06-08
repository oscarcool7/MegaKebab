class EventPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def destroy?
    update?
  end

  def show?
    password_guard!(record)
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

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end

  def password_guard!(event_context)
    return true if event_context.event.pincode.blank?
    return true if user.present? && user == event_context.event.user

    event_context.pincode.present? && event_context.event.pincode_valid?(event_context.pincode)
  end
end
