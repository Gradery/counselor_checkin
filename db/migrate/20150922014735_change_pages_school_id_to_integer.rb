class ChangePagesSchoolIdToInteger < ActiveRecord::Migration
  def change
  	remove_column :users, :school_id, :string
  	add_column :users, :school_id, :integer
  end
end
