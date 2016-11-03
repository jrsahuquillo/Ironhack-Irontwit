# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe 'The Irontwit' do
  context "homepage" do
  	before(:each) {get ("/")}

  	it "renders the homepage" do
  		expect(last_response).to be_ok
  	end

  	it "has a form" do
  		expect(last_response.body).to include("form")
  	end

  	it "adds a user" do
  		size = @@users.size
  		post("/register")
  		expect(@@users.size).to eq(size+1)
  	end

  	it "signs in a user" do
  		@@users = User.new("foo","1234")
  		expect(@@users.name).to eq("foo")
  		expect(@@users.password).to eq("1234")
  		# post("/profile")
  		# expect(session[:logged_in]).to eq(true)
  	end
  end

  context "register" do
  	before(:each) do
			@@users = User.new("","")
		end
  	it "try to registers a white register fields"	do	
  		post("/profile")
  		expect(session[:logged_in]).to be_falsey
  	end
  end
  		
  context "logout" do
  	it "should set the session as logged out" do
  		get("/logout")
  		expect(session[:logged_in]).to be_falsey
  	end
  end	
end