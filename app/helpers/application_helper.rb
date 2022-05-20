module ApplicationHelper
  def fa_icon(icon_class)
    content_tag "i", "", class: "bi bi-#{icon_class}"
  end

  def user_avatar(user)
    if user.avatar.attached?
      user.avatar
    else
      asset_path("user.jpg")
    end
  end
end
