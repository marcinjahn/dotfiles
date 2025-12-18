--------------------------------------------------------
 Windows for Docker v4.35...
 For support visit https://github.com/dockur/windows
--------------------------------------------------------

Using this folder you can share files with the host machine.

To change its location, include the following bind mount in your compose file:

  volumes:
    - "/home/example:/data"

Or in your run command:

  -v "/home/example:/data"

Replace the example path /home/example with the desired shared folder.

