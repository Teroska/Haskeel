import pytest

def add(a, b):
    return a + b

def divide(a, b):
    return a / b


def test_add_success():
    assert add(2, 2) == 4

def test_add_fail():
    assert add(2, 2) == 5 

def test_divide_success():
    assert divide(10, 2) == 5.0

def test_divide_zero_error():
    with pytest.raises(ZeroDivisionError):
        divide(10, 0)

        