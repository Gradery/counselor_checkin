class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.integer :school_id
      t.text :text

      t.timestamps
    end
  end
end
