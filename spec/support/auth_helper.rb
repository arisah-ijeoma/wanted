module AuthHelper
  def login(user)
    request.env['HTTP_AUTHORIZATION'] = user.access_token
  end
end
