ActiveAdmin.register Reason do
  belongs_to :school
  permit_params :text

  index do
    selectable_column
    id_column
    column :text
    actions
  end

  filter :text

  form do |f|
    f.inputs "Checkin Details" do
      f.input :text
      f.input :school, :collection => School.all
    end
    f.actions
  end

end