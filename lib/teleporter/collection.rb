require 'forwardable'

# This class serves as a proxy for storing records.
class Collection
  extend Forwardable

  def_delegators :@records, :first, :last, :size, :clear

  # @param klass        Class         Type to cast raw_data to.
  # @param raw_data     Array<Hash>   Some data.
  # @param unique_field Symbol        Primary key.
  def initialize(klass, raw_data, unique_field)
    @klass = klass
    @records = import_data(klass, raw_data)
    @unique_field = unique_field
  end

  # Checks if encapsulated array includes item.
  def include?(item)
    # FIXME
  end

  # Returns a new collection of objects filtered by a field and value pair.
  def where(field, value)
    # FIXME
  end

  # Inserts a new record and returns self.
  def insert(new_record)
    # FIXME
  end

  protected

  def import_data(raw_data)
    # FIXME
  end
end
