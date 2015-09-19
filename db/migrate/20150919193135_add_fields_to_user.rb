class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :is_admin, :boolean
    add_column :users, :school_id, :string
  end
end
