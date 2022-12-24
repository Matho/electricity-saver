module UptimeStatsHelper
  def table_tr_css(available)
    available ? 'success' : 'danger'
  end
  def table_td_up_or_down(uptime_stat)
    output = []

    if uptime_stat.available
      output << content_tag(:i, '', class: "bi bi-arrow-up-circle")
      output << content_tag(:span, ' UP', class: "")
    else
      output << content_tag(:i, '', class: "bi bi-arrow-down-circle")
      output << content_tag(:span, ' DOWN', class: "")
    end

    output.join.html_safe
  end
end
