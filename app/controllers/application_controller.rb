# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :current_user, if: -> { rodauth.logged_in? }
  before_action :retried_request?

  private

  def current_user
    @current_user ||= User::Account.find(rodauth.session_value)
  rescue ActiveRecord::RecordNotFound
    rodauth.logout
    rodauth.login_required
  end

  def authenticate
    rodauth.require_authentication # redirect to login page if not authenticated
  end

  helper_method :current_user, :authenticate
end
