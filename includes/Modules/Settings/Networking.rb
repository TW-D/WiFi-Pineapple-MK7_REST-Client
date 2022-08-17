module M_Networking

    public def interfaces()
        self.call(
            'GET',
            'settings/networking/interfaces',
            '',
            '[{'
        )
    end

    public def client_scan(interface)
        self.call(
            'POST',
            'settings/networking/clientmode/scan',
            {
                "interface" => interface
            },
            '{"results":['
        )
    end

    public def client_connect(network, interface)
        self.call(
            'POST',
            'settings/networking/clientmode/connect',
            {
                "ssid" => network.ssid,
                "bssid" => network.bssid,
                "password" => network.password,
                "encryption" => network.encryption,
                "hidden" => network.hidden,
                "interface" => interface
            },
            '{"success":true}'
        )
    end

    public def client_disconnect(interface)
        self.call(
            'POST',
            'settings/networking/clientmode/disconnect',
            {
                "interface" => interface
            },
            '{"success":true}'
        )
    end

    public def recon_interface(interface)
        self.call(
            'PUT',
            'settings/networking/recon/interface',
            {
                "interface" => interface
            },
            '{"success":true}'
        )
    end

end