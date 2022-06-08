require "rails_helper"

RSpec.describe User, type: :model do
  describe ".find_for_facebook_oauth" do
    let(:access_token) do
      double(
        :access_token,
        provider: "facebook",
        info: double(email: "oscarcool@rambler.ru"),
        extra: double(raw_info: double(id: "5030781246991060"))
      )
    end
    context "when user is not found" do
      it "returns newly created user" do
        user = User.find_for_facebook_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq "oscarcool@rambler.ru"
      end
    end

    context "when user is found by email" do
      let!(:existing_user) { FactoryBot.create(:user, email: "oscarcool@rambler.ru") }
      let!(:some_other_user) { FactoryBot.create(:user) }

      it "returns this user" do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end

    context "when user is found by provider + url" do
      let!(:existing_user) { FactoryBot.create(:user, provider: "facebook", url: "https://facebook.com/5030781246991060") }
      let!(:some_other_user) { FactoryBot.create(:user) }

      it "returns this user" do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end
  end
end
