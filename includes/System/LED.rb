module M_LED

    private def execute(state)

        begin

            Net::SSH.start(
                PineappleMK7::System::Authentication::PINEAPPLE_HOST, 
                'root', 
                :password => PineappleMK7::System::Authentication::PINEAPPLE_PASSWORD
            ) do |client|
                client.exec('/sbin/LED ' + state)
            end

            return(true)

        rescue Exception => exception

            abort('System::LED => ' + exception.message)

        end

    end

    public def setup()
        self.execute('SETUP')
    end

    public def failed()
        self.execute('FAIL')
    end

    public def attack()
        self.execute('ATTACK')
    end

    public def special()
        self.execute('SPECIAL')
    end

    public def cleanup()
        self.execute('CLEANUP')
    end

    public def finish()
        self.execute('FINISH')
    end

    public def off()
        self.execute('OFF')
    end

end