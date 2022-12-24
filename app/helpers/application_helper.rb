module ApplicationHelper
  def selected_menu(current_controller, menu_controller)
    current_controller == menu_controller ? 'text-secondary' : 'text-white'
  end

  def paginate_helper(resource)
    paginate resource, theme: 'bootstrap-5',
                       pagination_class: "pagination-sm flex-wrap justify-content-center",
                       nav_class: "d-inline-block"
  end
end
