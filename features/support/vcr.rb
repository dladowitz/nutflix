# require 'vcr_cucumber_helpers.rb'

# if ENV['WITH_SERVER'] == 'true'
#   start_sinatra_app(:port => 7777) do
#     get('/:path') { "Hello #{params[:path]}" }
#   end
# end

require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir     = 'features/cassettes'
  # c.default_cassette_options = { :record => :new_episodes }
  c.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  # Allows repeated tags of @vcr to be used
  t.tag '@vcr', use_scenario_name: true
end

