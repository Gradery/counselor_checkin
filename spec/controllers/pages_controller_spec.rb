require "rails_helper"

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
    it "has a 200 status code" do
      get :checkin, :school => @s.url
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :checkin, :school => @s.url
      expect(response).to render_template("checkin")
    end
  end
end