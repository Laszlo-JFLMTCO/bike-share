class Condition < ActiveRecord::Base

  def self.write(condition_details)
    self.find_or_create_by(condition_details)
  end

end