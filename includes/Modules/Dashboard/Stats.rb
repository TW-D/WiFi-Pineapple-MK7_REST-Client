module M_Stats

    public def output()
        self.call(
            'GET',
            'dashboard/cards',
            '',
            '{"systemStatus":{'
        )
    end

end