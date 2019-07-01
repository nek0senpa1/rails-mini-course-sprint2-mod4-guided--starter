class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      t.integer :cost
      t.integer :inventory
      t.datetime :deactivated_at
      t.string :name
      t.integer :purchase_count

      t.timestamps
    end
  end
end
