class ChangePagesSchoolIdToInteger < ActiveRecord::Migration
  def change
  	change_column :users, :school_id, :integer
  end
end
