#!python
# MyString.py - Contains all operations with string values that are not covered by Robot Framework

from robot.api import logger
from robot.utils import (is_bytes, is_string, is_truthy, is_unicode, lower,
                         unic, PY3)
import re


def is_string(item):
    # Returns False with `b'bytes'` on IronPython on purpose. Results of
    # `isinstance(item, basestring)` would depend on IronPython 2.7.x version.
    return isinstance(item, (str, unicode))


def is_truthy(item):
    if is_string(item):
        return item.upper() not in ('FALSE', 'NO', '')
    return bool(item)


def get_last_line_number_containing_pattern(string, pattern, case_insensitive=False):
    """Returns lines of the given ``string`` that contain the ``pattern``.

    The ``pattern`` is always considered to be a normal string, not a glob
    or regexp pattern. A line matches if the ``pattern`` is found anywhere
    on it.

    The match is case-sensitive by default, but giving ``case_insensitive``
    a true value makes it case-insensitive. The value is considered true
    if it is a non-empty string that is not equal to ``false`` or ``no``.
    If the value is not a string, its truth value is got directly in Python.

    Lines are returned as one string catenated back together with
    newlines. Possible trailing newline is never returned. The
    number of matching lines is automatically logged.

    Examples:
    | ${lines} = | Get Lines Containing String | ${result} | An example |
    | ${ret} =   | Get Lines Containing String | ${ret} | FAIL | case-insensitive |

    See `Get Lines Matching Pattern` and `Get Lines Matching Regexp`
    if you need more complex pattern matching.
    """


    if is_truthy(case_insensitive):  # handling, if case sensitivity is TRUE
        pattern = pattern.lower()  # transform pattern to lower case characters
        contains = lambda \
                line: pattern in line.lower()  # boolean 'contains' is set whether 'pattern' is contained in lowercase 'line'
    else:
        contains = lambda line: pattern in line


    currentline = 0

    patternregex = re.compile(r'.* + re.escape(pattern) + .*')

    lastline = 0
    # if contains:
    lines = string.splitlines()
    # for line in lines if contains(line):
    for line in lines:
        currentline = + 1
        if re.search(patternregex, line):
            lastline = currentline
            logger.info('lastline = ' + str(lastline))
    # matching = [line for line in lines if contains(line)]
    # logger.info('%d out of %d lines matched' % (len(matching), len(lines)))

    if lastline > 0:
        return lastline

    else:
        return logger.info('No matches')

        #
        # def _get_matching_lines(self, string, matches):
        #     lines = string.splitlines()
        #     matching = [line for line in lines if matches(line)]
        #     logger.info('%d out of %d lines matched' % (len(matching), len(lines)))
        #     return '\n'.join(matching)
