ActiveAdmin.register Setting do
  belongs_to :school
  permit_params :key, :value, :school_id

  index do
    selectable_column
    id_column
    column :key, :value
    actions
  end

  filter :key
  filter :value

  form do |f|
    f.inputs "Details" do
      f.input :key
      f.input :value
      f.input :school, :collection => School.all
    end
    f.actions
  end

end