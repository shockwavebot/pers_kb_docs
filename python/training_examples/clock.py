class Clock(object):
    def __init__(self, hour, minute):
        self.hour = divmod(hour + divmod(minute,60)[0], 24)[1]
        self.minute = divmod(minute, 60)[1]

    @property
    def time(self):
        return f"{self.hour:02}:{self.minute:02}"

    def __repr__(self):
        return self.time

    def __eq__(self, other):
        return self.time == other

    def __add__(self, minutes):
        return Clock(self.hour + divmod(minutes,60)[0], self.minute + divmod(minutes,60)[1])

    def __sub__(self, minutes):
        return Clock(self.hour - divmod(minutes,60)[0], self.minute - divmod(minutes, 60)[1])

