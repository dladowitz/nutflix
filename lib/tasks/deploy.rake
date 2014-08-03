require 'paratrooper'

namespace :deploy do
  desc 'Deploy app in staging environment'
  task :staging_because_i_said_so do
    deployment = Paratrooper::Deploy.new("nutflix-staging", tag: "staging")

    deployment.deploy
  end

  desc 'Deploy app in production environment'
  task :production do
    deployment = Paratrooper::Deploy.new("nutflix") do |deploy|
      deploy.tag              = 'production'
      deploy.match_tag        = 'staging'
    end

    deployment.deploy
  end
end
