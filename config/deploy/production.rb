server '178.62.181.53', roles: [:web,:app,:db], primary: true, user: fetch(:user)

set :branch, "master"
set :server_name, "locomotive.ivanbenko.com"


