class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user_id
      t.references :prototype_id
      t.timestamps
    end
  end
end
