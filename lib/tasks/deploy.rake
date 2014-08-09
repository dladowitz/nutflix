require 'paratrooper'

namespace :deploy do
  #### Disabling deploy:staging as we using Travis CI for staging deploys
  desc 'Deploy app in staging environment'
  task :staging do
    deployment = Paratrooper::Deploy.new("nutflix-staging", tag: "staging")

    deployment.deploy
  end

  desc 'Deploy app in production environment'
  task :production do
    deployment = Paratrooper::Deploy.new("nutflix") do |deploy|
      deploy.tag              = 'production'
      # deploy.match_tag        = 'staging'
    end

    deployment.deploy
  end
end
