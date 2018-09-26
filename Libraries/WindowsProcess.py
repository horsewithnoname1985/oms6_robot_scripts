#! python
# - This library executes commands on the OMS6 Client PC


# ROBOT_LIBRARY_SCOPE = "Oms6 Client Restart"


def findprocess(tasklist, process):
    success = tasklist.find(process)
    return success
