class ApplicationController < ActionController::Base

include SessionsHelper

def render_turbo_flash 
    turbo_stream.update("flash", partial: "shared/flash")
end

private def logged_in_user
    unless logged_in?
        store_location
        flash[:danger] = "Por favor efetue login para continuar."
    end
end

end
