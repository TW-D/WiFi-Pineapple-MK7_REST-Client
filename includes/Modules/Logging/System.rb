module M_System

    public def output()
        self.call(
            'GET',
            'logging/system',
            '',
            ''
        )
    end

end