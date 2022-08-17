#
# SPECIAL THANKS TO
# ======================
# @DrSKiZZ
# @cribb-it
# @barry99705
# @dark_pyrro
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

    reset_settings = PineappleMK7::Modules::PineAP::Settings.new
    reset_settings.save

    recon_scanning = PineappleMK7::Modules::Recon::Scanning.new
    SCAN_TIME = 300

    OPENAP_OUIS = {
        '00:C0:CA' => 'WiFi Pineapple NANO (Open AP)',
        '00:13:37' => 'WiFi Pineapple TETRA or Mark VII (Open AP)'
    }

    MANAGEMENTAP_OUIS = {
        '02:C0:CA' => 'WiFi Pineapple NANO (Management AP)',
        '00:13:37' => 'WiFi Pineapple TETRA (Management AP) or Mark VII (Evil WPA)',
        '02:13:37' => 'WiFi Pineapple Mark VII (Management AP)'
    }

    CLIENTMODE_OUIS = {
        '1C:BF:CE' => 'WiFi Pineapple NANO with Ralink USB WiFi RT5370 (Client Mode)',
        '00:13:37' => 'WiFi Pineapple TETRA (Client Mode)',
        '0C:EF:AF' => 'WiFi Pineapple Mark VII (Client Mode)'
    }

    # ATTACK
    #
    led.attack

    scanID = (recon_scanning.start(SCAN_TIME)).scanID
    output = recon_scanning.output(scanID)

    # SPECIAL
    #
    led.special
    
    puts('[@] WiFi Pineapple detected')

    (output.APResults).each do |ap|

        bssid = ap.bssid
        encryption = ap.encryption
        clients = ap.clients

        OPENAP_OUIS.each do |oui, type|
            if (bssid.start_with?(oui) and encryption === 'Open')
                puts("[>] #{(ap.ssid).inspect} - #{ap.bssid} - #{type}")
            end
        end

        MANAGEMENTAP_OUIS.each do |oui, type|
            if (bssid.start_with?(oui) and !(encryption === 'Open'))
                puts("[>] #{(ap.ssid).inspect} - #{ap.bssid} - #{type}")
            end
        end

        if (!clients.nil?)
            clients.each do |client|
                client_mac = client.client_mac
                CLIENTMODE_OUIS.each do |oui, type|
                    if (client_mac.start_with?(oui))
                        puts("[>] #{(ap.ssid).inspect} - #{client_mac} - #{type}")
                    end
                end
            end
        end

    end

    # FINISH
    #
    led.finish

    # CLEANUP
    #
    led.cleanup

    recon_scanning.delete(scanID)

    # OFF
    #
    led.off
  
end