module M_Impersonation

    public def output()
        response = self.call(
            'GET',
            'pineap/ssids',
            '',
            '{"ssids":'
        )
        ssids = response.ssids
        response.ssids = ((!ssids.empty?) ? ssids.split("\n") : [])
        return(response)
    end

    public def add_ssid(ssid)
        self.call(
            'PUT',
            'pineap/ssids/ssid',
            {
                "ssid" => Base64.urlsafe_encode64(ssid)
            },
            '{"success":true}'
        )
    end

    public def clear_pool()
        self.call(
            'DELETE',
            'pineap/ssids',
            '',
            '{"success":true}'
        )
    end

end