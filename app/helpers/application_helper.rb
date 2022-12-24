module ApplicationHelper
  def selected_menu(current_controller, menu_controller)
    current_controller == menu_controller ? 'text-secondary' : 'text-white'
  end
end
