#! python
# - This library includes all unspecified python functions

import os

# ROBOT_LIBRARY_SCOPE = "Oms6 Client Restart"


def convert_to_float(value):
    return float(value)


def convert_to_int(value):
    return int(value)


def check_if_two_strings_are_equal(string_a, string_b):
    if string_a == string_b:
        return True
    else:
        return False


def check_if_two_strings_are_different(string_a, string_b):
    if string_a == string_b:
        return False
    else:
        return True


def add(value1, value2):
    value1 = convert_to_int(value1)
    value2 = convert_to_int(value2)
    return value1 + value2


def substract(value1, value2):
    value1 = convert_to_int(value1)
    value2 = convert_to_int(value2)
    return value1 - value2


def remove_spaces(string):
    string = string.replace(' ', '')
    return string


def replace_spaces(string, replacement):
    string = string.replace(' ', replacement)
    return string


def get_absolute_path(relpath):
    return os.path.abspath(relpath)
