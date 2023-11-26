from prettytable import PrettyTable
from random import randint

def gain(account, trades, risk, rrr, hit_rate):
    """
    The function calculates the final account balance after a certain number of trades based on the
    risk, reward-to-risk ratio, and hit rate.
    
    :param account: The initial account balance
    :param trades: The parameter "trades" represents the number of trades that will be executed
    :param risk: The risk parameter represents the percentage of risk per trade. It determines how much
    of the account balance is at risk with each trade
    :param rrr: The parameter "rrr" stands for "Risk Reward Ratio". It is a measure used in trading to
    determine the potential profit or loss of a trade relative to the amount of risk taken. It is
    calculated by dividing the potential reward (profit) of a trade by the potential risk (loss) of
    :param hit_rate: The hit rate is the percentage of trades that are successful. For example, if the
    hit rate is 0.7, it means that 70% of the trades are successful
    :return: the final balance after executing the specified number of trades.
    """
    level = int(hit_rate*100)
    balance = account
    for _ in range(trades):
        if randint(1,100) <= level:
            balance = balance * (1 + risk*rrr/100)
        else:
            balance = balance * (1 - risk/100)
    return balance

def trade_num(account, x, risk, rrr, hit_rate):
    """
    The function calculates the number of trades needed to reach a target balance based on the given
    parameters.
    
    :param account: The initial account balance
    :param x: The parameter "x" represents the desired multiplication factor for the account balance. It
    is used to calculate the target balance, which is the balance that the account needs to reach in
    order for the loop to stop
    :param risk: The risk parameter represents the percentage of risk per trade. It determines how much
    of the account balance is risked in each trade
    :param rrr: The parameter "rrr" stands for "Risk Reward Ratio". It is a measure of the potential
    profit compared to the potential loss in a trade. For example, if the risk reward ratio is 2:1, it
    means that the potential profit is twice the potential loss
    :param hit_rate: The hit rate is the percentage chance of a trade being successful. For example, if
    the hit rate is 0.7, it means there is a 70% chance of a trade being successful
    :return: the number of trades needed to reach the target balance.
    """
    balance = account
    target_balance = account * x
    level = int(hit_rate*100)
    num = 0
    while balance < target_balance:
        if randint(1,100) <= level:
            balance = balance * (1 + risk*rrr/100)
        else:
            balance = balance * (1 - risk/100)
        num += 1
    return num

if __name__ == "__main__":
    account = 1000
    risk = 2
    rrr = 2.5
    strategy_hit_rate = 0.5
    trades_num = [10,20,50,100,200,300,500,1000,2000]
    cc = len(trades_num)
    new_balances = [round(gain(account, t, risk, rrr, strategy_hit_rate)) for t in trades_num]
    t = PrettyTable()
    t.add_column("Account", [account]*cc)
    t.add_column("Risk %", [risk]*cc)
    t.add_column("Strategy rate", [strategy_hit_rate]*cc)
    t.add_column("RRR", [rrr]*cc)
    t.add_column("Num trades", trades_num)
    t.add_column("New balance", new_balances)
    print(t)
    xes = 10
    print(f"How many trades to {xes}x the money?")
    hit_rete = [0.5, 0.5, 0.5, 0.6, 0.6, 0.6] 
    rrr_list = [1.2, 1.5, 2.0, 1.2, 1.5, 2.0]
    cc2 = len(hit_rete)
    tries = [trade_num(account, xes, risk, rrr, hr) for (hr, rrr) in zip(hit_rete, rrr_list)]
    t2 = PrettyTable()
    t2.add_column("Account", [account]*cc2)
    t2.add_column("Risk %", [risk]*cc2)
    t2.add_column("Strategy rate", hit_rete)
    t2.add_column("RRR", rrr_list)
    t2.add_column("Num trades", tries)
    print(t2)