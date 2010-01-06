class ByCurious::WidgetsController < ActionController::Base
  include ByCurious::ControllerExtensions
  authorize_resources

  def new
    render_success
  end

  def create
    render_success
  end

  def edit
    render_success
  end

  def update
    render_success
  end

  def destroy
    render_success
  end

  def resource
    @resource ||= ByCurious::Widget.new
  end

  def resource_class
    ByCurious::Widget
  end

  def current_user
    @current_user ||= ByCurious::User.new
  end

  private
    def render_success
      render :text => "Success"
    end

    def root_path
      "/"
    end
end

class ByCurious::Widget
  include ByCurious::ModelExtensions
  by_curious

  def self.creatable_by?(user)
    user && user.admin?
  end

  def editable_by?(user)
    user && user.admin?
  end 
end

class ByCurious::User
  attr_accessor :admin

  def admin?
    !self.admin.nil? && self.admin
  end
end

