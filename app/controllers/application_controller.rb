class ApplicationController < ActionController::Base

include SessionsHelper

private def logged_in_user
    unless logged_in?
        store_location
        flash[:danger] = "Por favor efetue login para continuar."
    end
end

end
