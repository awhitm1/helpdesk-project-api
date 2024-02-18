class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :assigned_tech, foreign_key: { to_table: :users }
      t.boolean :is_open
      t.references :category, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
