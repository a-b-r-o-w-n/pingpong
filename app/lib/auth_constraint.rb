class AuthConstraint
  def matches?(request)
    return false unless request.session["warden.user.user.key"][0][0].present?
    user ||= User.find( request.session["warden.user.user.key"][0][0] )
    user && user.admin?
  end
end
