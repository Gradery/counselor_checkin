class AddSchoolToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :school_id, :integer
  end
end
