"""Python test examples."""
# ! commentaire 1
# ! commentaire 2
# Not commentaire

import re
import time
from datetime import (datetime, date)


class OldStyleClass1:
    pass


class OldStyleClass2():
    pass


class Class3(object):
    """Doc string"""
    def __init__(self, param):
        self.param = param


class Class4(object):

    def class_method(self):
        pass

    def class_method_many_params(self, param1, param2):
        pass

    def _private_class_method(self):
        pass

    def class_method_multi_line1(
            self):
        pass

    def class_method_multi_line2(
            self, param1, param2):
        pass

    def class_method_unicode_Σ(self, param1):
        pass

    class Class4Nested(object):
        pass

class Class5(re.RegexObject):
    pass


class Class6Multiline(Class3,
                      Class4):
    pass


class Class7UnicodeΣ(object):
    pass


def function1():
    return time.time()  # Inline comment


def function2(param1, param2=Class3('%^$#'), param3=-4/2.0*3+1, param4='4', param5="5"):

    def function2_nested(param3, param4):
        return date(2000, 1, 1)

    pass

def function3(*args, **kwargs):
    return datetime(2000, 1, 1)

def function4_multi_line(
        param1, param2):
    pass


def function5_multi_line(param1,
                         param2):
    pass


def function6_not_method(self_test):
    pass


def function_unicode_Σ(param1):
    pass
