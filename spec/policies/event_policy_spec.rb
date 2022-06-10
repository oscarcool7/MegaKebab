require "rails_helper"

RSpec.describe EventPolicy, type: :policy do
  let(:user) { FactoryBot.create(:user) }
  let(:event_pincodeless) { FactoryBot.create(:event, user: user) }
  let(:event_pincoded) { FactoryBot.create(:event, user: user, pincode: "qwerty") }
  let(:cookies) { { "events_#{event_pincoded.id}_pincode" => "qwerty" } }

  subject { EventPolicy }

  context "user is the owner of event" do
    let(:event_owner) { UserContext.new(user, {}) }

    permissions :destroy?, :edit?, :update?  do
      it { is_expected.to permit(event_owner, event_pincodeless) }
    end

    permissions :show? do
      it { is_expected.to permit(event_owner, event_pincodeless) }
      it { is_expected.to permit(event_owner, event_pincoded) }
    end
  end

  context "user is not owner of event" do
    let(:usual_user) { FactoryBot.create(:user) }
    let(:usual_user_pincodeless) { UserContext.new(usual_user, {}) }
    let(:usual_user_pincoded) { UserContext.new(usual_user, cookies) }

    permissions :new?, :create? do
      it { is_expected.to permit(usual_user_pincodeless) }
    end

    permissions :destroy?, :edit?, :update?  do
      it { is_expected.not_to permit(usual_user_pincodeless, event_pincodeless) }
    end

    permissions :show? do
      it { is_expected.to permit(usual_user_pincodeless, event_pincodeless) }
      it { is_expected.not_to permit(usual_user_pincodeless, event_pincoded) }
      it { is_expected.to permit(usual_user_pincoded, event_pincoded) }
    end
  end

  context "user is the anonymous" do
    let(:anon_pincodeless) { UserContext.new(nil, {}) }
    let(:anon_pincoded) { UserContext.new(nil, cookies) }

    permissions :new?, :create? do
      it { is_expected.not_to permit(anon_pincoded) }
    end

    permissions :destroy?, :edit?, :update?  do
      it { is_expected.not_to permit(anon_pincoded, event_pincoded) }
    end

    permissions :show? do
      it { is_expected.to permit(anon_pincoded, event_pincoded) }
      it { is_expected.to permit(anon_pincodeless, event_pincodeless)}
    end
  end
end
