class Clock:
    def __init__(self, hour, minute):
        self.time = divmod((hour*60 + minute)%(24*60), 60)

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
