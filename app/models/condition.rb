class Condition < ActiveRecord::Base

  has_many :trips, class_name: "Trip", primary_key: "date", foreign_key: "start_date"

  validates :date,
            :max_temperature_f,
            :mean_temperature_f,
            :min_temperature_f,
            :mean_humidity,
            :mean_visibility_miles,
            :max_wind_speed_mph,
            :precipitation_inches, presence: true

  def self.write(condition_details)
    find_or_create_by(condition_details)
  end

  def self.days_with_high_temps_between(range)
    where(max_temperature_f: range)
  end

  def self.grouped_by_date_number_of_trips
    joins(:trips).group(:date).count("id")
  end

  def self.grouped_days_in_range(range)
    days_with_high_temps_between(range).joins(:trips).group(:date).count("id")
  end

  def self.average_number_of_rides_in_range(range)
    (grouped_days_in_range(range).values.reduce(:+).to_f / grouped_days_in_range(range).values.count).round(2)
  end

  def self.highest_number_of_rides_in_range(range)
    grouped_days_in_range(range).values.sort.last
  end

  def self.lowest_number_of_rides_in_range(range)
    grouped_days_in_range(range).values.sort.first
  end

end