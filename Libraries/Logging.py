#!python
# Logging.py - This file manages standard python logging for debugging purposes


import logging

logging.basicConfig(level=logging.INFO)


def debug_log(message):
    logging.info('debug_log_INFO ' + str(message))


def cmdprint(message):
    print(str(message))