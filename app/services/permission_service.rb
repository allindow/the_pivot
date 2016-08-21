class PermissionService
attr_reader :user

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    return platform_admin_permissions(controller, action) if user.platform_admin?
    return org_admin_permissions(controller, action) if user.org_admin?
    return registered_user_permissions(controller, action) if user.registered_user?
    return guest_permissions(controller, action)
  end

  private
    def platform_admin_permissions(controller, action)
      return true if controller == "sessions"
      return true if controller == "users"
      return true if controller == "recipients"
      return true if controller == "organizations"
      return true if controller == "fundings"
      return true if controller == "carts"
      return true if controller == "organizations/recipients"
      return true if controller == "country/recipients"
      return true if controller == "admin/recipients"
      return true if controller == "admin/dashboard"
    end

    def org_admin_permissions(controller, action)
      return true if controller == "sessions"
      return true if controller == "recipients"
      return true if controller == "organizations"
      return true if controller == "fundings"
      return true if controller == "carts"
      return true if controller == "organizations/recipients"
      return true if controller == "organizations/dashboard"
      return true if controller == "country/recipients"
      return true if controller == "admin/recipients"
      return true if controller == "users"

    end

    def registered_user_permissions(controller, action)
      return true if controller == "sessions"
      return true if controller == "recipients" && action.in?(%w(index show))
      return true if controller == "organizations" && action.in?(%w(index show new create))
      return true if controller == "fundings"
      return true if controller == "carts"
      return true if controller == "organizations/recipients"
      return true if controller == "organizations/dashboard"
      return true if controller == "country/recipients"
      return true if controller == "admin/recipients"
      return true if controller == "users" && action.in?(%w(show))
    end

    def guest_permissions(controller, action)
      return true if controller == "sessions"
      return true if controller == "users" && action.in?(%w(new show create))
      return true if controller == "recipients"
      return true if controller == "organizations" && action.in?(%w(index show))
      return true if controller == "organizations/dashboard"
      return true if controller == "carts"
      return true if controller == "organizations/recipients"
      return true if controller == "country/recipients"
      return true if controller == "api/v1/progress"
    end

end
