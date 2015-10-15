class CreateUserReasons < ActiveRecord::Migration
  def change
    create_table :reasons_users do |t|
      t.integer :user_id
      t.integer :reason_id

      t.timestamps
    end
  end
end
