def func(x):
    return x + 1


def test_answer_fail():
    assert func(3) == 5


def test_answer_true():
    assert func(4) == 5
