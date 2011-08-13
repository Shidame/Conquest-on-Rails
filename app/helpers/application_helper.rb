module ApplicationHelper
  def debug_bar
    return "" unless debug?
    render 'debug/bar'
  end
end
