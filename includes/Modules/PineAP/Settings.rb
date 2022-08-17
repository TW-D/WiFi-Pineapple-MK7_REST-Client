module M_Settings

    def initialize()
        @enablePineAP = true
        @autostartPineAP = true
        @armedPineAP = false
        @ap_channel = '11'
        @karma = false
        @logging = false
        @connect_notifications = false
        @disconnect_notifications = false
        @capture_ssids = false
        @beacon_responses = false
        @broadcast_ssid_pool = false
        @broadcast_ssid_pool_random = false
        @pineap_mac = PineappleMK7::System::Authentication::PINEAPPLE_MAC
        @target_mac = 'FF:FF:FF:FF:FF:FF'
        @beacon_response_interval = 'NORMAL'
        @beacon_interval = 'NORMAL'
    end

    public def save()
        self.call(
            'PUT',
            'pineap/settings',
            {
                "mode" => "advanced",
                "settings" => {
                    "enablePineAP" => @enablePineAP,
                    "autostartPineAP" => @autostartPineAP,
                    "armedPineAP" => @armedPineAP,
                    "ap_channel" => @ap_channel,
                    "karma" => @karma,
                    "logging" => @logging,
                    "connect_notifications" => @connect_notifications,
                    "disconnect_notifications" => @disconnect_notifications,
                    "capture_ssids" => @capture_ssids,
                    "beacon_responses" => @beacon_responses,
                    "broadcast_ssid_pool" => @broadcast_ssid_pool,
                    "broadcast_ssid_pool_random" => @broadcast_ssid_pool_random,
                    "pineap_mac" => @pineap_mac,
                    "target_mac" => @target_mac,
                    "beacon_response_interval" => @beacon_response_interval,
                    "beacon_interval" => @beacon_interval
                }
            },
            '{"success":true}'
        )
    end

end