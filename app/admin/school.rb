ActiveAdmin.register School do
  permit_params :name, :is_student, :badge_id, :child_name, :user_id, :custom_reason, :reason_id, :reason_text, :school_id

  index do
    selectable_column
    id_column
    column :name
    column :url
    column (:checkins) {|school| link_to("Checkins", admin_school_checkins_path(school.id)) }
    column (:reasons) {|school| link_to("Reasons", admin_school_reasons_path(school.id)) }
    column (:users) {|school| link_to("Users", admin_school_users_path(school.id)) }
    column (:settings) {|school| link_to("Settings", admin_school_settings_path(school.id)) }
    actions
  end

  filter :name
  filter :url
  filter :created_at

  form do |f|
    f.inputs "School Details" do
      f.input :name
      f.input :url
    end
    f.actions
  end
end