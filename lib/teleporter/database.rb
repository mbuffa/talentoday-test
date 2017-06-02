require 'json'

class Database
  # TODO: Extract this to configuration.
  KEY_TO_CLASS = {
    teleporters: Teleporter,
    reservations: Reservation
  }.freeze

  def initialize(constraints_path, data_path)
    @collections = {}
    @constraints = {}
    import_constraints(constraints_path)
    import_data(data_path)
  end

  def clear
    @collections.keys.each do |key|
      @collections[key] = []
    end
  end

  private

  # TODO: [LATER] Extract that dependency to JSON someway.

  # Sets :@constraints on collections of objects from a json file.
  def import_constraints(constraints_path)
    # FIXME
  end

  # Builds :@collections of objects from a json file.
  def import_data(data_path)
    # FIXME
  end
end
