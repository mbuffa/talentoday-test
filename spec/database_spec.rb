require 'spec_helper'

describe 'Database' do
  before do
    @fixtures = [
      'spec/fixtures/unique_keys.json', 'spec/fixtures/database.json'
    ]
  end

  it { expect { Database }.not_to raise_error }

  %w(reservations teleporters).each do |name|
    it { expect { Database.new(*@fixtures).send(name) }.not_to raise_error }
  end

  context 'with fixtures' do
    before { @database = Database.new(*@fixtures) }

    it { expect(@database.teleporters.size).to eq 3 }
    it { expect(@database.reservations.size).to eq 0 }

    context 'with some additional data' do
      before do
        teleporter_id = 1
        time = Time.now.utc
        # TODO: DRY this!
        @database.reservations.insert Reservation.new(teleporter_id, time)
        @database.reservations.insert Reservation.new(teleporter_id, time)
      end

      after do
        @database.clear
      end

      it 'stores records' do
        teleporter_id = 5
        location_name = 'Lyon'
        teleporter = Teleporter.new(teleporter_id, location_name)
        @database.teleporters.insert teleporter
        expect(@database.teleporters).to include(teleporter)
      end

      it 'returns expected data' do
        expect(@database.reservations.where(:teleporter_id, 1).first.teleporter_id).to eq 1
      end

      it 'filters data' do
        expect(@database.reservations.where(:teleporter_id, 0).first).to be_nil
      end

      it 'verifies uniqueness' do
        expect(@database.reservations.size).to eq 1
      end

      it 'prevents inserting wrong objects in collections' do
        teleporter_id = 4
        location_name = 'Madrid'
        @database.reservations.clear
        expect { @database.reservations.insert Teleporter.new(teleporter_id, location_name) }.to raise_error
      end

      it 'clears data' do
        teleporter_id = 4
        location_name = 'Madrid'
        @database.teleporters.insert Teleporter.new(teleporter_id, location_name)
        expect { @database.teleporters.clear }.to change { @database.teleporters.size }.to 0
      end
    end
  end
end
