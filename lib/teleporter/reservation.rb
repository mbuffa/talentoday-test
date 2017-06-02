class Reservation
  attr_accessor :teleporter_id, :departure_time

  def initialize(teleporter_id = nil, departure_time = nil)
    @teleporter_id = teleporter_id
    @departure = departure_time
  end
end
