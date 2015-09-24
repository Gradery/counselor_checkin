require "rails_helper"

include Devise::TestHelpers

RSpec.describe PagesController do
  before(:each) do
    @s = FactoryGirl.create(:school)
  end
  describe "GET /" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET /:school/" do
    it "has a 200 status code if the school exists" do
      get :checkin, :school => @s.url
      expect(response.status).to eq(200)
    end

    it "renders the checkin template if the school exists" do
      get :checkin, :school => @s.url
      expect(response).to render_template("checkin")
    end

    it "has a 404 status code if the school doesn't exist" do
      get :checkin, :school => 800
      expect(response.status).to eq(404)
    end
  end

  describe "GET /:school/admin" do
    it "has a 404 status code if the school doesn't exist" do
      get :admin, :school => 800
      expect(response.status).to eq(404)
    end

    it "has status 400 if the current user doesn't belong to that school" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      school = FactoryGirl.create(:school)
      school.save!
      sign_in user

      ap user.school
      ap school

      get :admin, :school => school.url
      expect(response.status).to eq(400)
    end

    it "has status 200 if the current user belongs to that school" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      sign_in user

      get :admin, :school => user.school.url
      expect(response.status).to eq(200)
    end
  end
end