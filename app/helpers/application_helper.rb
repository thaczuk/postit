module ApplicationHelper
  def display_datetime(dt)
    dt.strftime("%A, %B %e, %Y @ %H:%M" )
  end

  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
end
