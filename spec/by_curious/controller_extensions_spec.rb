require 'spec_helper'

require 'lib/by_curious/spec_helper'

describe ByCurious::ControllerExtensions, :type => :controller do
  
  controller_name "ByCurious::Widgets"

  before(:each) do
    @admin = ByCurious::User.new
    @admin.admin = true

    @user = ByCurious::User.new
  end

  def set_current_user(user)
    controller.stubs(:current_user).returns(user)
  end

  context "creation" do
    it "should deny access to create if the user doesn't have create privileges" do
      set_current_user(@user)
      do_create_post
      response.should be_redirect
    end

    it "should deny access to create if I'm not logged in" do
      set_current_user(false)
      do_create_post
      response.should be_redirect
    end

    it "should allow access to create if the user has create privileges" do
      set_current_user(@admin)
      do_create_post
      response.should be_success
    end  

    def do_create_post
      post :create
    end

    def do_new_get
      get :new
    end
  end

  it "should authorize by default if the model does not define a by? method" do
    set_current_user(false)
    do_destroy_delete
    response.should be_success
  end
  
  def do_destroy_delete
    delete :destroy
  end
end
