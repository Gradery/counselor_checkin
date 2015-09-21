ActiveAdmin.register User do
  belongs_to :school
  permit_params :email, :password, :password_confirmation, :name, :is_admin, :school_id, :honorific

  index do
    selectable_column
    id_column
    column :honorific
    column :name
    column :email
    column :is_admin
    actions
  end

  filter :name
  filter :name
  filter :email
  filter :is_admin

  form do |f|
    f.inputs "Checkin Details" do
      f.input :honorific, :collection => ["Dr.","Mr.","Mrs.","Ms."]
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :is_admin
      f.input :school, :collection => School.all
    end
    f.actions
  end

end