module ApplicationHelper
  def countries
    Country.all
  end

  def platform_admin?
    current_user && current_user.platform_admin?
  end

  def org_admin?
    current_user && current_user.org_admin?
  end

  def registered_user?
    current_user && current_user.registered_user?
  end 
end
