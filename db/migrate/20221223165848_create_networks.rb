class CreateNetworks < ActiveRecord::Migration[7.0]
  def change
    create_table :networks do |t|
      t.string :title
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
