class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authenticate_request
  skip_before_action :authenticate_request, only: [:authenticate]
   attr_reader :current_user

   def authenticate_sign_up
     command = AuthenticateUser.call(params[:email], params[:password])
    @auth_token = command.result
   end

   private

   def authenticate_request
     @current_user = AuthorizeApiRequest.call(request.headers).result
     render json: { error: 'Not Authorized' }, status: 401 unless @current_user
   end
end
