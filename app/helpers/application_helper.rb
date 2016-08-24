module ApplicationHelper
  def countries
    Country.order(:name)
  end

  def countries_with_recipients
    Country.order(:name).select do |country|
      country.recipients != []
    end
  end

  def all_funds_raised
    Recipient.sum(:amount_received).to_i
  end

  def lend_amounts
    [20, 30, 40, 50, 60, 70, 80, 90, 100]
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
