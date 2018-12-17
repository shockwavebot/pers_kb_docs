import pytest
from pi_const import get_pi
from decimal import Decimal

def test_01_2_decimals():
    assert get_pi(2) == round(Decimal(3.14),2)
def test_02_5_decimals():
    assert get_pi(5) == round(Decimal(3.14159),5)
def test_03_10_decimals():
    assert get_pi(10) == round(Decimal(3.1415926536),10)
def test_04_15_decimals():
    assert get_pi(15) == round(Decimal(3.141592653589793),15)
def test_05_0_decimals():
    with pytest.raises(ValueError):
        get_pi(0)
def test_06_16_decimals():
    with pytest.raises(ValueError):
        get_pi(16)
