class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # protect_from_forgery with: :exception
  # layout :detect_browser
  #
  #
  # private
  #
  # def mobile_device?
  #     if session[:mobile_param]
  #       session[:mobile_param] == "1"
  #     else
  #       request.user_agent =~ /Mobile|webOS/
  #     end
  #   end
  #
  # def detect_browser
  #   layout = selected_layout
  #   return layout if layout
  #   mobile_device? ? "mobile_application" : "application"
  # end
  #
  # def selected_layout
  #   session.inspect
  #   if session.has_key? "layout"
  #     return (session["layout"]=="mobile")? "mobile_application" : "application"
  #   end
  #   return nil
  # end
  #


  before_filter :prepare_for_mobile
  protect_from_forgery with: :exception
  layout :choose_layout


  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    # request.format = :mobile if mobile_device?
    request.variant = :mobile if mobile_device?
  end

  def choose_layout
    (mobile_device?)?"mobile_application":"application"
  end

end
