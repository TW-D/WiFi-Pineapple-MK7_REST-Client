module M_Filtering

    public def client_filter(mode)
        self.call(
            'PUT',
            'pineap/filters/client/mode',
            {
                "mode" => mode
            },
            '{"success":true}'
        )
    end

    public def add_client(mac)
        self.call(
            'PUT',
            'pineap/filters/client/list',
            {
                "mac" => mac
            },
            '{"success":true}'
        )
    end

    public def clear_clients()
        self.call(
            'DELETE',
            'pineap/filters/client/list',
            {
                "mac" => ""
            },
            '{"success":true}'
        )
    end

    public def ssid_filter(mode)
        self.call(
            'PUT',
            'pineap/filters/ssid/mode',
            {
                "mode" => mode
            },
            '{"success":true}'
        )
    end

end