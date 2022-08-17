module M_EvilWPA

    def initialize()
        @ssid = "PineAP_WPA"
        @bssid = "00:13:37:BE:EF:00"
        @auth = "psk2+ccmp"
        @password = "pineapplesareyummy"
        @hidden = false
        @enabled = false
        @capture_handshakes = false
    end

    public def save()
        self.call(
            'PUT',
            'settings/networking/ap/wpa',
            {
                "ssid" => @ssid,
                "bssid" => @bssid,
                "auth" => @auth,
                "password" => @password,
                "confirm_password" => @password,
                "hidden" => @hidden,
                "enabled" => @enabled,
                "capture_handshakes" => @capture_handshakes
            },
            '{"success":true}'
        )
    end

end