module PingStatsHelper
  def table_td_ok_or_warn(ping_stat)
    output = []

    if ping_stat.response_code == 'OK'
      output << content_tag(:i, '', class: "bi bi-check-circle")
    else
      output << content_tag(:i, '', class: "bi bi-exclamation-triangle")
    end

    output << content_tag(:span, " #{ping_stat.response_status}")

    output.join.html_safe
  end
end
