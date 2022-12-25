class AddIndexesToCurrentStates < ActiveRecord::Migration[7.0]
  def change
    add_index :current_states, :created_at
    add_index :current_states, :updated_at
  end
end
