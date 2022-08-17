module M_Scanning

    #
    # https://github.com/libwifi/libwifi/blob/main/src/libwifi/core/misc/security.h (L85 at L89)
    #
    SECURITY_TYPE_VALUES = {
        'WEP' => 0x01,
        'WPA' => 0x02,
        'WPA2' => 0x03,
        'WPA3' => 0x04
    }

    private def convert_encryption(encryption)
        security_type = ''
        if (encryption != 0)
            SECURITY_TYPE_VALUES.each do |key, value|
                if ((encryption & (1 << value)) != 0)
                    security_type = key
                    break
                end
            end
            return(security_type)
        else
            return('Open')
        end
    end

    private def lookup_oui(mac)
        oui = (mac.split(':')[0..2].join)
        response = self.call(
            'GET',
            ('helpers/lookupOUI/' + oui),
            '',
            '{"available":'   
        )
        return(
            (response.available) ? response.vendor : 'Unknown Vendor'
        )
    end

    public def start(scan_time)

        response = self.call(
            'POST',
            'recon/start',
            {
                "live" => false,
                "autoHandshake" => false,
                "scan_time" => (scan_time === 0) ? 30 : scan_time,
                "band" => "2"
            },
            '{"scanRunning":true,"scanID":'   
        )

        total = (scan_time + 5)
        progressbar = ProgressBar.new('Progression of the recon scan [:bar]', width: 100, total: total)
        total.times do
            sleep(1)
            progressbar.advance
        end

        return(response)
        
    end

    public def start_continuous(autoHandshake)
        response = self.call(
            'POST',
            'recon/start',
            {
                "live" => false,
                "autoHandshake" => autoHandshake,
                "scan_time" => 0,
                "band" => "2"
            },
            '{"scanRunning":true,"scanID":'   
        )
        sleep(5)
        return(response)
    end

    public def stop_continuous()
        self.call(
            'POST',
            'recon/stop',
            '',
            '{"success":true}'   
        )
    end

    public def output(scanID)

        response = self.call(
            'GET',
            ('recon/scans/' + scanID.to_s()),
            '',
            '{"APResults":['
        )

        ap_results = response.APResults
        if (!ap_results.nil?)
            ap_results.each do |ap|
                ap.oui = self.lookup_oui(ap.bssid)
                ap.encryption = self.convert_encryption(ap.encryption)
                clients = ap.clients
                if (!clients.nil?)
                    clients.each do |client|
                        client.client_oui = self.lookup_oui(client.client_mac)
                    end
                end
            end
        else
            response.APResults = []
        end

        unassociated_results = response.UnassociatedClientResults
        if (!unassociated_results.nil?)
            unassociated_results.each do |client|
                client.client_oui = self.lookup_oui(client.client_mac)
            end
        else
            response.UnassociatedClientResults = []
        end

        outofrange_results = response.OutOfRangeClientResults
        if (!outofrange_results.nil?)
            outofrange_results.each do |client|
                client.client_oui = self.lookup_oui(client.client_mac)
            end
        else
            response.OutOfRangeClientResults = []
        end

        return(response)

    end

    public def tags(ap)
        self.call(
            'POST',
            'recon/tags',
            {
                "scan_id" => ap.scan_id,
                "bssid" => ap.bssid
            },
            '[{"scan_id":'   
        )
    end

    public def deauth_ap(ap)

        clients_mac = []
        ap.clients.each do |client|
            clients_mac << client.client_mac
        end

        self.call(
            'POST',
            'pineap/deauth/ap',
            {
                "bssid" => ap.bssid,
                "multiplier" => 7,
                "channel" => ap.channel,
                "clients" => clients_mac
            },
            '{"success":true}'
        )

    end

    public def delete(scanID)
        self.call(
            'DELETE',
            ('recon/scans/' + scanID.to_s()),
            '',
            '{"success":true}'
        )
    end

end