def increase(x):
    return x + 1


def test_service_fail():
    assert increase(3) == 5


def test_service_true():
    assert increase(4) == 5
