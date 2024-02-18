class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.string :email
      t.boolean :is_tech
      t.boolean :is_admin
      t.boolean :active

      t.timestamps
    end
  end
end
