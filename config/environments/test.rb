Myflix::Application.configure do
  config.cache_classes = true

  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection    = false

  #### Mailer Options
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = {
    :host => "127.0.0.1",
    :port => 5000
  }

  config.active_support.deprecation = :stderr

  # Do full stripe network tests once a week
  if Date.today.strftime("%a") == "Mon"
    STRIPE_RECORD_MODE = { record: :all }
  else
    STRIPE_RECORD_MODE = { record: :once }
  end
end
