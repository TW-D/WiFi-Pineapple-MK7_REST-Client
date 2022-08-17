require('json')
require('base64')
require('net/ssh')
require('fileutils')
require('rest-client')
include(RestClient)
require('tty-progressbar')
include(TTY)

## HELPERS

# Downloader helper
#
require_relative('../includes/Helpers/Downloader.rb')

# Requester helper
#
require_relative('../includes/Helpers/Requester.rb')

## MODULES

# Dashboard module
#
require_relative('../includes/Modules/Dashboard/Stats.rb')
require_relative('../includes/Modules/Dashboard/Notifications.rb')

# Logging module
#
require_relative('../includes/Modules/Logging/System.rb')

# PineAP modules
#
require_relative('../includes/Modules/PineAP/Clients.rb')
require_relative('../includes/Modules/PineAP/EvilWPA.rb')
require_relative('../includes/Modules/PineAP/Filtering.rb')
require_relative('../includes/Modules/PineAP/Impersonation.rb')
require_relative('../includes/Modules/PineAP/OpenAP.rb')
require_relative('../includes/Modules/PineAP/Settings.rb')

# Recon modules
#
require_relative('../includes/Modules/Recon/Handshakes.rb')
require_relative('../includes/Modules/Recon/Scanning.rb')

# Settings module
#
require_relative('../includes/Modules/Settings/Networking.rb')

# System modules
#
require_relative('../includes/System/Authentication.rb')
require_relative('../includes/System/LED.rb')

module PineappleMK7

    class Modules

        class Dashboard

            class Stats
                include(Requester)
                include(M_Stats)
            end

            class Notifications
                include(Requester)
                include(M_Notifications)
            end

        end

        class Logging

            class System
                include(Requester)
                include(M_System)
            end

        end

        class PineAP

            class Clients
                include(Requester)
                include(M_Clients)
            end

            class EvilWPA
                attr_accessor(
                    :ssid,
                    :bssid,
                    :auth,
                    :password,
                    :hidden,
                    :enabled,
                    :capture_handshakes
                )
                include(Requester)
                include(M_EvilWPA)
            end

            class Filtering
                include(Requester)
                include(M_Filtering)
            end

            class Impersonation
                include(Requester)
                include(M_Impersonation)
            end

            class OpenAP
                include(Requester)
                include(M_OpenAP)
            end

            class Settings
                attr_accessor(
                    :enablePineAP, 
                    :autostartPineAP, 
                    :armedPineAP, 
                    :ap_channel,
                    :karma,
                    :logging,
                    :connect_notifications,
                    :disconnect_notifications,
                    :capture_ssids,
                    :beacon_responses,
                    :broadcast_ssid_pool,
                    :broadcast_ssid_pool_random,
                    :pineap_mac,
                    :target_mac,
                    :beacon_response_interval,
                    :beacon_interval
                )
                include(Requester)
                include(M_Settings)
            end

        end

        class Recon

            class Handshakes
                include(Requester)
                include(Downloader)
                include(M_Handshakes)
            end

            class Scanning
                include(Requester)
                include(M_Scanning)
            end

        end

        class Settings

            class Networking
                include(Requester)
                include(M_Networking)
            end

        end

    end

    class System

        class Authentication
            attr_accessor(:host, :port, :mac)
            attr_writer(:password)
            include(M_Authentication)
        end

        class LED
            include(M_LED)
        end

    end

end