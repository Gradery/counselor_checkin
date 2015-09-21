ActiveAdmin.register Checkin do
  belongs_to :school
  permit_params :name, :is_student, :badge_id, :child_name, :user_id, :custom_reason, :reason_id, :reason_text, :school_id

  index do
    selectable_column
    id_column
    column :name
    column :is_student
    column :badge_id
    column :child_name
    column :created_at
    actions
  end

  filter :name
  filter :is_student
  filter :created_at

  form do |f|
    f.inputs "Checkin Details" do
      f.input :name
      f.input :is_student
      f.input :badge_id
      f.input :child_name
      f.input :user_id
      f.input :custom_reason
      f.input :reason, :collection => Reason.where(:school_id => params['school_id']).all
      f.input :reason_text
      f.input :school, :collection => School.all
    end
    f.actions
  end

end