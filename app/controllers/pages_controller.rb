class PagesController < ApplicationController
	before_action :authenticate_user!, :only => :admin

	def index

	end

	def checkin

	end

	def admin

	end
end