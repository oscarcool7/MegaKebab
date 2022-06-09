class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    provider
  end

  def vkontakte
    provider
  end

  private

  def provider
    @user = User.find_for_oauth(request.env["omniauth.auth"])
    provider = request.env['omniauth.auth'].provider

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider)

      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t("devise.omniauth_callbacks.failure", kind: provider, reason: "authentication error")

      redirect_to root_path
    end
  end
end
