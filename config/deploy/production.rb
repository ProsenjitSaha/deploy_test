set :stage, :production
server '139.59.9.135', user: 'deploy', roles: %w{web app db}
