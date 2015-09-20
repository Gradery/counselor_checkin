require "rails_helper"

RSpec.describe ApiController do
	before(:each) do
	    @s = FactoryGirl.create(:school)
	end

	describe "POST /api/checkin" do
	    it "has a 404 status code if school not provided" do
	      post :add_checkin
	      expect(response.status).to eq(404)
	    end

	    it "sets @school if school is passed" do
	      post :add_checkin, :school => @s.url
	      expect(assigns(:school)).to eq @s
	    end

	    it "has a 404 status code if counselor not found" do
	    	post :add_checkin, :school => @s.url, :user_id => 2000
	      	expect(response.status).to eq(404)
		end

		it "has a 400 status code if validation fails" do
	    	user = FactoryGirl.create(:user)
	    	post :add_checkin, :school => @s.url, :user_id => user.id, :name => "", :user_type => "student", :badge_id => "123", :custom_reason => "true", :custom_reason_text => "text"
	      	expect(response.status).to eq(400)
		end

		it "saves a new object if required params are passed for a student with a custom reason" do
			user = FactoryGirl.create(:user)
			post :add_checkin, :school => @s.url, :user_id => user.id, :name => "name", :user_type => "student", :badge_id => "123", :custom_reason => "true", :custom_reason_text => "text"
			expect(response.status).to eq(200)
		end

		it "saves a new object if required params are passed for a student with an existing reason" do
			user = FactoryGirl.create(:user)
			reason = FactoryGirl.create(:reason)
			post :add_checkin, :school => @s.url, :user_id => user.id, :name => "name", :user_type => "student", :badge_id => "123", :custom_reason => "false", :reason_id => reason.id
			expect(response.status).to eq(200)
		end

		it "saves a new object if required params are passed for a parent with a custom reason" do
			user = FactoryGirl.create(:user)
			post :add_checkin, :school => @s.url, :user_id => user.id, :name => "name", :user_type => "parent", :student_name => "123", :custom_reason => "true", :custom_reason_text => "text"
			expect(response.status).to eq(200)
		end

		it "saves a new object if required params are passed for a parent with an existing reason" do
			user = FactoryGirl.create(:user)
			reason = FactoryGirl.create(:reason)
			post :add_checkin, :school => @s.url, :user_id => user.id, :name => "name", :user_type => "parent", :student_name => "123", :custom_reason => "false", :reason_id => reason.id
			expect(response.status).to eq(200)
		end
	end
end