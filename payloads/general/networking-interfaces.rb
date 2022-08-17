require_relative('../../classes/PineappleMK7.rb')

system_authentication = PineappleMK7::System::Authentication.new
system_authentication.host = "172.16.42.1"
system_authentication.port = 1471
system_authentication.mac = "00:13:37:DD:EE:FF"
system_authentication.password = "<ROOT-ACCOUNT-PASSWORD>"

if (system_authentication.login)

    settings_networking = PineappleMK7::Modules::Settings::Networking.new
    interfaces = settings_networking.interfaces
    interfaces.each do |interface|
        pp(interface)
    end

end