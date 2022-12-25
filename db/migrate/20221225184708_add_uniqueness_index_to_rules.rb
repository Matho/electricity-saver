class AddUniquenessIndexToRules < ActiveRecord::Migration[7.0]
  def change
    add_index :rules, [:action, :smart_plug_device_id], unique: true
  end
end
