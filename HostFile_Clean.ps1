﻿$hosts =@'
# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.
#
# This file contains the mappings of IP addresses to host names. Each
# entry should be kept on an individual line. The IP address should
# be placed in the first column followed by the corresponding host name.
# The IP address and the host name should be separated by at least one
# space.
#
# Additionally, comments (such as these) may be inserted on individual
# lines or following the machine name denoted by a '#' symbol.
#
# For example:
#
#      102.54.94.97     rhino.acme.com          # source server
#       38.25.63.10     x.acme.com              # x client host

# localhost name resolution is handled within DNS itself.
#	127.0.0.1       localhost
#	::1             localhost

0.0.0.0 test.com
0.0.0.1 test1.com
0.0.0.2 test2.com
'@
Clear-Content -Path 'C:\windows\System32\drivers\etc\hosts'
$hosts | Out-File -encoding ASCII -append 'C:\windows\System32\drivers\etc\hosts'