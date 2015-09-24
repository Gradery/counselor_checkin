require "rails_helper"

include Devise::TestHelpers

RSpec.describe ApiController do
	before(:each) do
	    @s = FactoryGirl.create(:school)
	    @user = FactoryGirl.create(:user)
	    @user.is_admin = true
	    @user.save
		sign_in @user
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

	describe "POST /api/reasons" do
		it "has a status 404 if the school is not found" do
			post :add_reason, :school => "asdfasdfasdfsdfasdfasdf"
			expect(response.status).to eq(404)
		end

		it "has a status 404 if the school is not the user's" do
			post :add_reason, :school => @s.url
			expect(response.status).to eq(404)
		end

		it "has status 200 if all fields are valid" do
			post :add_reason, :school => @user.school.url, :text => "abc"
			expect(response.status).to eq(200)
		end
	end

	describe "PUT /api/reasons/:id" do
		it "updates valid attributes" do
			r = FactoryGirl.create(:reason)
			put :update_reason, :id => r.id, :reason => {:text => "asdfasdfsd"}
			expect(response.status).to eq(204)
		end
	end

	describe "POST /api/reasons/:id/delete" do
		it "has status 200 and works" do
			r = FactoryGirl.create(:reason)
			post :delete_reason, :id => r.id
			expect(response.status).to eq(200)
		end
	end

	describe "POST /api/users" do
		it "has status 400 if user's school is not the school" do
			u = FactoryGirl.build(:user)
			post :add_user, :school => @s.url
			expect(response.status).to eq(400)
		end

		it "has status 400 if correct school but user is not an admin" do
			u = FactoryGirl.build(:user)
			u.is_admin = false
			u.save!
			post :add_user, :school => u.school.url
			expect(response.status).to eq(400)
		end

		it "saves user if valid params and user is not admin" do
			post :add_user, :school => @user.school.url, :email => "something@test.com", :name => "name", :honorific => "Mr.", :is_admin => false
			expect(response.status).to eq(200)
		end

		it "saves user if valid params and user is admin" do
			post :add_user, :school => @user.school.url, :email => "something2@test.com", :name => "name", :honorific => "Mr.", :is_admin => true
			expect(response.status).to eq(200)
		end

		it "has status 400 if user is not valid" do
			post :add_user, :school => @user.school.url, :email => "something", :name => "name", :honorific => "Mr.", :is_admin => false
			expect(response.status).to eq(400)
		end

		it "returns a message about the validation error" do
			post :add_user, :school => @user.school.url, :email => "something", :name => "name", :honorific => "Mr.", :is_admin => false
			expect(response.body).to eq("{\"error\":{\"email\":[\"is invalid\"]}}")
		end
	end

	describe "PUT /api/users/:id" do
		it "updates a user correctly" do
			put :update_user, :id => @user.id, :user => {:name => "test user"}
			expect(response.status).to eq(204)
		end

		it "spits back validation errors" do
			put :update_user, :id => @user.id, :user => {:email => "tesdsdfsf"}
			expect(response.body).to eq("{\"email\":[\"is invalid\"]}")
		end

		it "has status 422 for validation errors" do
			put :update_user, :id => @user.id, :user => {:email => "tesdsdfsf"}
			expect(response.status).to eq(422)
		end
	end

	describe "POST /api/users/:id/delete" do
		it "will not let a user delete themselves" do
			post :delete_user, :id => @user.id
			expect(response.body).to eq("{\"error\":\"You can't delete yourself!\"}")
		end

		it "will destoy a user successfully" do
			u = FactoryGirl.create(:user)
			post :delete_user, :id => u.id
			expect(response.body).to eq("{\"error\":\"You can't delete yourself!\"}")
		end
	end
end