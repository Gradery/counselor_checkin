class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.string :name
      t.boolean :is_student
      t.string :badge_id
      t.string :child_name
      t.integer :user_id
      t.boolean :custom_reason
      t.integer :reason_id
      t.text :reason_text

      t.timestamps
    end
  end
end
