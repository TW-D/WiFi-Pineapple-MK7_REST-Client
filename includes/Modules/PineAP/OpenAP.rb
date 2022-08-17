module M_OpenAP

    public def output()
        self.call(
            'GET',
            'settings/networking/ap/open',
            '',
            '{"ssid":"'
        )
    end

end