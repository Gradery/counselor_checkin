class AddUrlToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :url, :string
  end
end
