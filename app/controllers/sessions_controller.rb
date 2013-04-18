require_relative "../commands/users/sign_in_user"

class Stringer < Sinatra::Base
  get "/login" do
    erb :"sessions/new"
  end

  post "/login" do
    user = SignInUser.sign_in(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:notice] = "Logged in!"
      redirect to("/")
    else
      flash.now[:error] = "Invalid username or password"
      erb :"sessions/new"
    end
  end

  get "/logout" do
    session[:user_id] = nil
    redirect to("/")
  end
end