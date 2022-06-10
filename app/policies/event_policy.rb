class EventPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def create?
    new?
  end

  def destroy?
    update?
  end

  def new?
    user.present?
  end

  def show?
    return true if record.pincode.blank?
    return true if is_owner?
    return true if record.pincode_valid?(cookies["events_#{record.id}_pincode"])

    false
  end

  def update?
    user_is_owner?
  end

  private

  def user_is_owner?
    user == record.user
  end
end
