*** Settings ***
Resource  camera_commands.robot

*** Keywords ***
the server sends tele camera images
    #TODO: Define a method to check, if the server is sending tele camera images

the server sends wide camera images
    #TODO: Define a method to check, if the server is sending wide camera images

the server sends camera images of both cameras
    camera_commands.select WIDE camera
    run keyword  the server sends wide camera images
    camera_commands.select TELE camera
    run keyword  the server sends wide camera images