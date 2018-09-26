#! python
# SendKeys.py - Contains methods where key input is needed

import pyautogui
from robot.api import logger


def weasel_login(user, pw):
    pyautogui.typewrite(user)
    pyautogui.typewrite("\t")
    pyautogui.typewrite(pw)
    pyautogui.typewrite("\n")


def say_hello():
    logger.info("Hello there!")


def send_keys(keys):
    pyautogui.typewrite(keys)
