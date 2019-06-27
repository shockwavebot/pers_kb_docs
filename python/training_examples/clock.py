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

# v2

class Clock:
    def __init__(self, hour, minute):
        self.time = divmod((hour*60 + minute)%1440, 60)

    @property
    def now(self):
        return f"{self.time[0]:02}:{self.time[1]:02}"

    def __repr__(self):
        return self.now

    def __eq__(self, other):
        return self.now == other

    def __add__(self, minutes):
        return Clock(0, self.time[0]*60 + self.time[1] + minutes)

    def __sub__(self, minutes):
        return Clock(0, self.time[0]*60 + self.time[1] - minutes)
