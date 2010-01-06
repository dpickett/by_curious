require 'spec_helper'

require 'lib/by_curious/spec_helper'

describe ByCurious::Helper, :type => :controller do
  before(:each) do
    @user = ByCurious::User.new
    @admin = ByCurious::User.new
    @admin.admin = true
    @widget = ByCurious::Widget.new
  end

  def set_current_user(user)
    controller.stubs(:current_user).returns(user)
  end


  controller_name "ByCurious::Widgets"
  context "can? when specifying an instance" do

    it "should indicate that I can update an instance" do
      set_current_user(@user)
      controller.can?(:edit, @widget).should be_false
    end

    it "should indicate that I can't update an instance" do
      set_current_user(@admin)
      controller.can?(:edit, @widget).should be_true
    end

  end

  context "cannot? when specifying an instance" do
    it "should indicate that I cannot update an instance" do
      set_current_user(@user)
      controller.cannot?(:edit, @widget).should be_true
    end
    
    it "shoulld indicate that I can update an instance" do
      set_current_user(@admin)
      controller.cannot?(:edit, @widget).should be_false
    end
  end

  context "can? when specifying a class" do
    it "should indicate that I can create a class instance" do
      set_current_user(@user)
      controller.can?(:create, ByCurious::Widget).should be_false
    end

    it "should indicate that I cannot create a class instance" do
      set_current_user(@admin)
      controller.can?(:create, ByCurious::Widget).should be_true
    end
  end

  context "cannot? when specifying a class" do
    it "should indicate that I cannot create a class instance" do
      set_current_user(@user)
      controller.cannot?(:create, ByCurious::Widget).should be_true
    end
    
    it "should indicate that I can create a class instance" do
      set_current_user(@admin)
      controller.cannot?(:create, ByCurious::Widget).should be_false
    end
  end
end
