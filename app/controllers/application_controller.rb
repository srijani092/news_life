class ApplicationController < ActionController::Base
  protect_from_forgery

  	before_filter :cors_preflight_check
before_filter :set_cache_buster
after_filter :cors_set_access_control_headers

	def cors_set_access_control_headers
headers['Access-Control-Allow-Origin'] = '*'
headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE'
headers['Access-Control-Max-Age'] = "1728000"
end




def cors_preflight_check
if request.method == :options
headers['Access-Control-Allow-Origin'] = '*'
headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE'
headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
headers['Access-Control-Max-Age'] = '1728000'
render :text => '', :content_type => 'text/plain'
end
end
	def set_cache_buster
response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
response.headers["Pragma"] = "no-cache"
response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
end

def method_options?
request.request_method == 'OPTIONS' 
end

helper_method :admin?

protected
def admin?

session[:password] == 'foobar'
	end
def authorize
  unless admin?
    flash[:error] = "unauthorized access"
    redirect_to home_index_path
    false
  end
end




end
