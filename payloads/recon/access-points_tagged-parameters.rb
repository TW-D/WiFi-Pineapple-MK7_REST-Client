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
    SCAN_TIME = 120

    # ATTACK
    #
    led.attack

    scanID = (recon_scanning.start(SCAN_TIME)).scanID
    output = recon_scanning.output(scanID)

    # SPECIAL
    #
    led.special
    
    puts('[@] Access Points - Tagged Parameters')
    (output.APResults).each do |ap|
        puts('')
        puts("[+] #{(ap.ssid).inspect} - #{ap.bssid}")
        (recon_scanning.tags(ap)).each do |tags|
            tag_bytes = [tags.tag_data].pack('H*')
            tag_data = tag_bytes.gsub(/[^[:print:]]/i, '.')
            if (!tag_data.empty?)
                puts("[>] #{tag_data}")
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