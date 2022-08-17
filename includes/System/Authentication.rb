module M_Authentication

    public def login()

        begin

            url = ('http://' + @host + ':' + @port.to_s + '/api/')

            response = Request.execute(
                method: :post,
                url: (url + 'login'),
                timeout: 10,
                payload: {
                    'username' => "root",
                    'password' => @password
                }.to_json,
                headers: {
                    content_type: :json,
                    accept: :json
                }
            )

            body = response.body

        rescue Exception => exception

            abort('System::Authentication => ' + exception.message)

        else

            if (body.include?('{"token":"'))

                self.class.const_set(:API_URL, url)
                self.class.const_set(:BEARER_TOKEN, JSON.parse(body)['token'])
                self.class.const_set(:PINEAPPLE_HOST, @host)
                self.class.const_set(:PINEAPPLE_MAC, @mac)
                self.class.const_set(:PINEAPPLE_PASSWORD, @password)
                return(true)

            else

                return(false)

            end

        end

    end

end