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
    WIGLE_API = 'AIDxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx:yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'

    # ATTACK
    #
    led.attack

    scanID = (recon_scanning.start(SCAN_TIME)).scanID
    output = recon_scanning.output(scanID)

    # SPECIAL
    #
    led.special
    
    puts('[+] Access Points - Wireless Network Mapping with WiGLE')

    (output.APResults).each do |ap|
        ssid = URI.encode_www_form_component(ap.ssid)
        bssid = ap.bssid
        IO.popen(
            [
                'curl',
                '--silent',
                '--connect-timeout 10',
                '--request GET',
                '--header \"Accept: application/json\"',
                "--user #{WIGLE_API}",
                "--basic",
                "\"https://api.wigle.net/api/v2/network/search?onlymine=false&freenet=false&paynet=false&ssid=#{ssid}&netid=#{bssid}\""
            ].join(' '),
            'r'
        ) do |io|
            wigle_output = JSON.parse(io.gets)
            if (wigle_output['success'])
                pp(ap)
                pp(wigle_output)
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