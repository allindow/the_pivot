module PlatformHelper
  def self.pending?
    status == "pending"
  end

  def self.inactive?
    status == "inactive"
  end
end
