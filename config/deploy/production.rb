set :stage, :production
server '139.59.40.48', user: 'deploy', roles: %w{web app db}
