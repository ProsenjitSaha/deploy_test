set :stage, :production
server '139.59.42.189', user: 'deploy', roles: %w{web app db}
