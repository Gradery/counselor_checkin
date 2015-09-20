class AddHonorificToUser < ActiveRecord::Migration
  def change
    add_column :users, :honorific, :string
  end
end
