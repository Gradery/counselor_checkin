class ApiController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authenticate_user!, :except => :add_checkin

	def add_checkin
		# check for missing params
		ap params
		@school = get_school
		if @school.nil?
			render json: {error: "School Not Found"}, status: 404
		else
			# see if the user exists
			if User.where(:id => params['user_id']).exists?
				# create the Reason model
				checkin = Checkin.new
				checkin.school = @school
				checkin.name = params['name']
				checkin.user = User.find(params['user_id'])
				if params['user_type'] == "student"
					checkin.is_student = true
					checkin.badge_id = params['badge_id']
				else
					checkin.is_student = false
					checkin.child_name = params['student_name']
				end
				if params['custom_reason'] == "true"
					checkin.custom_reason = true
					checkin.reason_text = params['custom_reason_text']
				else
					checkin.custom_reason = false
					checkin.reason = Reason.find(params['reason_id'])
				end
				if checkin.save
					render json: {success: true}
				else
					render json: {error: checkin.errors.messages}, status: 400
				end
			else
				render json: {error: "Counselor Not Found"}, status: 404
			end
		end
	end

	private

	def get_school
		if !params['school'].nil?
			if School.where(:url => params['school']).exists?
				return School.where(:url => params['school']).first
			else
				return nil
			end
		else
			return nil
		end
	end
end