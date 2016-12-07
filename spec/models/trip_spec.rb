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

  describe "Methods" do
    describe "average duration of a ride" do
      it "returns nil when no trips are in database table" do
        expect(Trip.rides_average_duration).to eq(nil)
      end
      it "returns proper value with one entry in database table" do
        test_trip = Trip.write(duration: 90,
                                  start_date: "2011-3-6 12:00",
                                  start_station_id: 1,
                                  end_date: "2011-3-6 12:00",
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_type: "Subscriber", 
                                  zipcode: 80211)
                                  
        expect(Trip.rides_average_duration).to eq(90)
      end
      it "returns proper value with more than one entry in database table" do
        test_trip1 = Trip.write(duration: 90,
                                  start_date: "2011-3-6 12:00",
                                  start_station_id: 1,
                                  end_date: "2011-3-6 12:00",
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_type: "Subscriber", 
                                  zipcode: 80211)
        test_trip2 = Trip.write(duration: 45,
                                  start_date: "2011-6-6 12:00",
                                  start_station_id: 1,
                                  end_date: "2011-6-6 12:00",
                                  end_station_id: 3,
                                  bike_id: 3,
                                  subscription_type: "Subscriber", 
                                  zipcode: 80211)
                                  
        expect(Trip.rides_average_duration).to eq(67.5)
      end
    end
  end

end