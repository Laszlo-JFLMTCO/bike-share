require_relative '../spec_helper'

describe "Trip" do

  describe "validations" do
    it "will not save without duration" do
      invalid_trip = Trip.create(start_date: "2011-3-6 12:00",
                                start_station_id: 1,
                                end_date: "2011-3-6 12:00",
                                end_station_id: 3,
                                bike_id: 3,
                                subscription_id: 1,
                                zipcode: 80211)

      expect(invalid_trip).to_not be_valid
    end

    it "will not save without start_date and start_station_id" do
      invalid_trip1 = Trip.create(duration: 45,
                                  start_station_id: 1,
                                  end_date: "2011-3-6 12:00",
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_id: 1,
                                  zipcode: 80211)
      invalid_trip2 = Trip.create(start_station_id: 1,
                                  end_date: "2011-3-6 12:00",
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_id: 1,
                                  zipcode: 80211)
      
      expect(invalid_trip1).to_not be_valid
      expect(invalid_trip2).to_not be_valid
    end

    it "will not save without end_date and end_station_id" do
      invalid_trip1 = Trip.create(duration: 45,
                                  start_station_id: 1,
                                  end_date: "2011-3-6 12:00",
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_id: 1,
                                  zipcode: 80211)
      invalid_trip2 = Trip.create(duration: 45,
                                  start_date:  "2011-3-6 12:00",
                                  start_station_id: 1,
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_id: 1,
                                  zipcode: 80211)

      expect(invalid_trip1).to_not be_valid
      expect(invalid_trip2).to_not be_valid
    end

    it "will not save without zipcode" do
      invalid_trip = Trip.create(duration: 45,
                                start_date: "2011-3-6 12:00",
                                start_station_id: 1,
                                end_date: "2011-3-6 12:00",
                                end_station_id: 3,
                                bike_id: 3,
                                subscription_id: 1)
      expect(invalid_trip).to_not be_valid
    end

    it "will not save without subscription_type" do
      invalid_trip = Trip.create(duration: 45,
                                start_date: "2011-3-6 12:00",
                                start_station_id: 1,
                                end_date: "2011-3-6 12:00",
                                end_station_id: 3,
                                bike_id: 3,
                                zipcode: 80211)
      expect(invalid_trip).to_not be_valid
    end

  end

  describe "Dashboard Methods" do
    it "find the longest ride" do
      trip1 = Trip.write(duration: 45,
                          start_date: "2011-3-6 12:00",
                          start_station_id: 1,
                          end_date: "2011-3-6 12:00",
                          end_station_id: 3,
                          bike_id: 3,
                          subscription_name: "Subscriber",
                          zipcode: 80211)
      trip2 = Trip.write(duration: 47,
                          start_date: "2011-3-6 12:00",
                          start_station_id: 1,
                          end_date: "2011-3-6 12:00",
                          end_station_id: 3,
                          subscription_name: "Subscriber",
                          bike_id: 3,
                          zipcode: 80211)

      expect(Trip.longest_ride).to eq(47)
    end

    it "find the station with the most rides as a starting place" do
      trip1 = Trip.write(duration: 45,
                          start_date: "2011-3-6 12:00",
                          start_station_id: 1,
                          end_date: "2011-3-6 12:00",
                          end_station_id: 3,
                          bike_id: 3,
                          subscription_name: "Subscriber",
                          zipcode: 80211)
      trip2 = Trip.write(duration: 47,
                          start_date: "2011-3-6 12:00",
                          start_station_id: 1,
                          end_date: "2011-3-6 12:00",
                          end_station_id: 3,
                          subscription_name: "Subscriber",
                          bike_id: 3,
                          zipcode: 80211)
      trip3 = Trip.write(duration: 47,
                          start_date: "2011-3-6 12:00",
                          start_station_id: 2,
                          end_date: "2011-3-6 12:00",
                          end_station_id: 3,
                          subscription_name: "Subscriber",
                          bike_id: 3,
                          zipcode: 80211)

      expect(Trip.station_with_most_starting_rides).to eq("Station1")
    end
  end

end