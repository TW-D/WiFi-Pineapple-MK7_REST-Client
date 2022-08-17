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

    # ATTACK
    #
    led.attack

    scanID = (recon_scanning.start_continuous(false)).scanID

    begin

        loop do

            sleep(INTERVAL)

            $stdout.clear_screen

            # SPECIAL
            #
            led.special

            output = recon_scanning.output(scanID)

            puts('[+] Access Points with/without Clients')
            (output.APResults).each do |ap|
                pp(ap)
            end

            puts('[+] Unassociated Clients')
            (output.UnassociatedClientResults).each do |client|
                pp(client)
            end

            puts('[+] Out-of-Range Clients')
            (output.OutOfRangeClientResults).each do |client|
                pp(client)
            end

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

        # OFF
        #
        led.off

    end
  
end