class Api::V1::UsersController < Api::V1::BaseController
	respond_to :json
	before_action :doorkeeper_authorize!, except: [:sign_in, :sign_up]

	def sign_up
	    app = authorize_application
	    if app == 404
	      render json: {message: 'APP does not exist', ok: false}, status: 404
	    else
	      user = User.new(user_params)
	      if user.save
	        render json: {user: sign_in_user_data(user), ok: true, access_token: user.generate_access_token(@app).token}
	      else
	        render json: {message: user.errors.full_messages.join(',') , ok: false}
	      end
	    end
  	end

	def sign_in
		app = authorize_application
	    if app == 404
	    	render json: {message: 'App does not exist', ok: false}, status: 404
	    else
	    	user = User.find_by(email: params[:email])
		    if user.present?
		    	if user.valid_password?(params[:password])
					render json: {user: sign_in_user_data(user), ok: true, access_token: user.generate_access_token(@app).token}
				else
				    render json: {message: 'Email or Password Is Not Valid', ok: false}
			    end
		    else
		        render json: {message: 'Email Not Found', ok: false}
	      	end
	    end
	end

	def sign_out
	    if current_token.try(:revoke)
	      render json: {ok: true, message: 'Signed Out'}
	    else
	      render json: {ok: false, message: 'Invalid AccessToken'}
	    end
	end

	private

	def sign_in_user_data(user)
	    data = {
	        id: user.id,
	        email: user.email,
	    }
  	end

  	def user_params
  		params[:user].permit(:email, :password)
  	end

end

