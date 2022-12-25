class RemovePeriodFromCurrentStates < ActiveRecord::Migration[7.0]
  def change
    remove_column :current_states, :period
  end
end
