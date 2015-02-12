server '5.101.106.130', roles: [:web,:app,:db], primary: true, user: fetch(:user)

set :branch, "master"
set :server_name, "loc.stein-pilz.com *.loc.stein-pilz.com stein-pilz.com www.stein-pilz.com"


