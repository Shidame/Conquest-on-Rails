module DebugHelper
  def debug_bar
    return "" unless debug?
    render 'debug/bar'
  end
  
  def link_to_sign_in_as(user)
    link_to_unless user == current_user,
                   user.name,
                   sign_in_path(session: { email: user.email }),
                   method: "post"
  end
end
