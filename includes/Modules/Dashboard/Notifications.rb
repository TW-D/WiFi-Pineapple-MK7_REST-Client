module M_Notifications

    public def clear()
        self.call(
            'DELETE',
            'notifications',
            '',
            '{"success":true}'
        )
    end

end