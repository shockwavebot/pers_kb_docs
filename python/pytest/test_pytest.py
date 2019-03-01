

##########################################################################################################################
# EXAMPLE
##########################################################################################################################
import datetime

ORDERS = [
{'buy_order_id': '2123', 'sell_order_id': '2124', 'order_time': datetime.datetime(2019, 3, 1, 11, 2, 9, 214531)},
{'buy_order_id': '2125', 'sell_order_id': '2126', 'order_time': datetime.datetime(2019, 3, 1, 12, 2, 16, 226771)},
{'buy_order_id': '2127', 'sell_order_id': '2128', 'order_time': datetime.datetime(2019, 3, 1, 13, 2, 23, 244673)},
{'buy_order_id': '2129', 'sell_order_id': '2130', 'order_time': datetime.datetime(2019, 3, 1, 14, 2, 30, 256863)}
]

target = datetime.datetime(2019, 3, 1, 12, 30)

def logic_under_test(orders, target_date_time, res_before, res_after):
    RC=0
    for order in orders:
        order_id = order['buy_order_id']
        order_time = order['order_time']
        print(f'{order_id} {order_time}')
        if order_time <= target_date_time:
            if order_id in res_before:
                print("Info: Order {} | {} | is IN the DB".format(order_id, order_time))
            else:
                print("Error: Order {} | {} | is missing in the DB".format(order_id, order_time))
                RC=1
        else:
            if order_id not in res_after and order_id not in res_before:
                print("Info: Order {} | {} | not in the DB as expected".format(order_id,order_time))
            else:
                print("Error: {} {} shold NOT be in the DB.".format(order_id, order_time))
                RC=2
    return RC


def test_all_as_expected():
    assert logic_under_test(ORDERS, target, ['2123','2125'], []) == 0

def test_missing_one_order():
    assert logic_under_test(ORDERS, target, ['2123'], []) == 1

def test_order_wrongly_in_db():
    assert logic_under_test(ORDERS, target, ['2123','2125'], ['2129']) == 2

def test_order_wrongly_in_before_list():
    assert logic_under_test(ORDERS, target, ['2123','2125','2129'], []) == 2
##########################################################################################################################
