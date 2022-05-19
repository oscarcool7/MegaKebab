module ApplicationHelper
  def fa_icon(icon_class)
    content_tag "span", "", class: "fa fa-#{icon_class}"
  end

  def user_avatar(user)
    asset_path("user.jpg")
  end
end
