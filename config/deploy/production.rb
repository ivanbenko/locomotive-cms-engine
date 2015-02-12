server '178.62.181.53', roles: [:web,:app,:db], primary: true, user: fetch(:user)

set :branch, "master"
set :server_name, "*.loc.appouting.com loc.appouting.com www.dubina.by dubina.by stein-pilz.com www.stein-pilz.com"


