require "rails_helper"

RSpec.describe EventPolicy, type: :policy do
  let(:user_is_the_owner) { User.new }
  let(:user_is_not_the_owner) { User.new }
  let(:event) { Event.new(user: user_is_the_owner, pincode: "qwerty") }
  let(:event_context1) { EventContext.new(event: event, pincode: "qwerty") }
  let(:event_context2) { EventContext.new(event: event, pincode: "qwe") }

  subject { EventPolicy }

  context "authorized user" do
    permissions :edit?, :destroy?, :update? do
      context "is the owner of event" do
        it "gets the access" do
          is_expected.to permit(user_is_the_owner, event)
        end
      end

      context "is not the owner of event" do
        it "does not get the access" do
          is_expected.not_to permit(user_is_not_the_owner, event)
        end
      end
    end

    permissions :show? do
      context "the right pincode" do
        it "gets the access" do
          is_expected.to permit(user_is_the_owner, event_context1)
          is_expected.to permit(user_is_not_the_owner, event_context1)
        end
      end

      context "the wrong pincode" do
        it "does not get the access" do
          is_expected.not_to permit(user_is_not_the_owner, event_context2)
        end
      end
    end
  end

  context "unregistered user" do
    permissions :edit?, :destroy?, :update? do
      it "does not get the access" do
        is_expected.not_to permit(nil, event)
      end
    end

    permissions :show? do
      context "the right pincode" do
        it "gets the access" do
          is_expected.to permit(nil, event_context1)
        end
      end

      context "the wrong pincode" do
        it "does not get the access" do
          is_expected.not_to permit(nil, event_context2)
        end
      end
    end
  end
end
