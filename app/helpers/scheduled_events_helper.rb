module ScheduledEventsHelper
  def table_td_on_or_off(rule)
    output = []

    if rule.action == 'turn_on'
      output << content_tag(:i, '', class: "bi bi-wifi")
      output << content_tag(:span, ' ON', class: "")
    else
      output << content_tag(:i, '', class: "bi bi-wifi-off")
      output << content_tag(:span, ' OFF', class: "")
    end

    output.join.html_safe
  end
end
