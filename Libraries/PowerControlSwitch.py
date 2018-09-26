#! python
# - This library executes commands on the Expert Power Control NET 8x switch


"""A library for *documentation format* demonstration purposes.

This documentation is created using reStructuredText__. Here is a link
to the only \`Keyword\`.

__ http://docutils.sourceforge.net
"""

import urllib

ROBOT_LIBRARY_SCOPE = "Oms6 Client Restart"


def restore_power(power_switch_ip, port_number):
    urllib.urlopen("http://" + power_switch_ip + "/?cmd=1&p=" + port_number + "&s=1")


def kill_power(power_switch_ip, port_number):
    urllib.urlopen("http://" + power_switch_ip + "/?cmd=1&p=" + port_number + "&s=0")
