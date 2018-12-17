from decimal import Decimal

# Nilakantha series
# π = 3 + 4/(2*3*4) - 4/(4*5*6) + 4/(6*7*8) - 4/(8*9*10) + 4/(10*11*12) - 4/(12*13*14) ...

def get_pi(decimals=2):
    if decimals < 1 or decimals > 15:
        raise ValueError('Decimals not in range.')
    pi, op, denom = Decimal(3), 1, 2
    for i in range(1000000):
        pi = pi + Decimal(op*4/(denom*(denom+1)*(denom+2)))
        op = op * (-1)
        denom = denom+2
    return round(pi, decimals)
