class CreateNetworks < ActiveRecord::Migration[7.0]
  def change
    create_table :networks do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.boolean :active, null: false, default: false

      t.timestamps
    end
  end
end
