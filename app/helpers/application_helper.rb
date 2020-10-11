module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.png'
    end
  end

  def declination(count, okonchanie, okonchania, okonchanij) # <- передаєм question.size
    return okonchanij if (11..14).include? count % 100 # <- виключення

    case count % 10
    when 1 then okonchanie
    when (2..4) then okonchania
    when (5..9), 0 then okonchanij
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
