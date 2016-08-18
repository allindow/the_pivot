class PermissionService
attr_reader :user

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller)
    return platform_admin_permissions(controller) if user.platform_admin?
    return org_admin_permissions(controller) if user.org_admin?
    return registered_user_permissions(controller) if user.registered_user?
    return guest_permissions(controller)
  end

  private
    def platform_admin_permissions(controller)
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

    def org_admin_permissions(controller)
      return true if controller == "sessions"
      return true if controller == "recipients"
      return true if controller == "organizations"
      return true if controller == "fundings"
      return true if controller == "carts"
      return true if controller == "organizations/recipients"
      return true if controller == "country/recipients"
      return true if controller == "admin/recipients"
      return true if controller == "admin/dashboard"
    end

    def registered_user_permissions(controller)
    end

    def guest_permissions(controller)
    end

end
