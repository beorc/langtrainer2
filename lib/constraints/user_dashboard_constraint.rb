class UserDashboardConstraint
  def self.matches?(request)
    arr = request.fullpath.split('/')
    return false if arr.size != 2
    username = arr.last.split('?').first
    User.find_by(username: username).present?
  end
end


