class AddPeriodToCurrentStates < ActiveRecord::Migration[7.0]
  def change
    add_column :current_states, :period, :integer, null: false, default: 0
  end
end
