# Copied direct from Kiaros, not really sure whats all happening. Especially with Database Cleaner
# Called when cucumbers run

Cucumber::Rails::World.use_transactional_fixtures

require Rails.root.join("spec","support","fixture_builder.rb")

ActiveRecord::FixtureSet.reset_cache
fixtures_folder = Rails.root.join('spec', 'fixtures')
fixtures = Dir[File.join(fixtures_folder, '*.yml')].map {|f| File.basename(f, '.yml') }
fixtures += Dir[File.join(fixtures_folder, '*.csv')].map {|f| File.basename(f, '.csv') }

DatabaseCleaner.clean_with :truncation

ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)    # This will populate the test database tables

module FixtureAccess

  def self.extended(base)
    (class << base; self; end).class_eval do
      @@fixture_cache = {}
      ActiveRecord::FixtureSet.cache_for_connection(ActiveRecord::Base.connection).each do |table_name, fixtures|
        define_method(table_name) do |*fixture_symbols|
          @@fixture_cache[table_name] ||= {}

          instances = fixture_symbols.map do |fixture_symbol|
            if fixtures[fixture_symbol.to_s]
              @@fixture_cache[table_name][fixture_symbol] ||= fixtures[fixture_symbol.to_s].find  # find model.find's the instance
            else
              raise StandardError, "No fixture with name '#{fixture_symbol}' found for table '#{table_name}'"
            end
          end
          instances.size == 1 ? instances.first : instances
        end
      end
    end
  end
end

World(FixtureAccess)
