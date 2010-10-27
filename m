From: Yonggang Liu <myidpt@gmail.com>
Subject: mds port 6800 socket closed when accessing mount point
Date: Wed, 27 Oct 2010 12:42:13 -0400
Message-ID: <AANLkTindXNKvAYcN1WLN7VDdTz41DATMgNgfqbMm5879@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63230 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0J0QmO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Oct 2010 12:42:14 -0400
Received: by ewy7 with SMTP id 7so794820ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 27 Oct 2010 09:42:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I'm totally new to Ceph. Last a few days I set up 4 VMs to run Ceph:
"mds0" for the metadata server and monitor, "osd0" and "osd1" for two
data servers, and "client" for the client machine. The VMs are running
Debian 5.0 with kernel 2.6.32-5-686 (Ceph module is enabled).
I followed "Building kernel client" and "Debian" from the wiki, and I
was able to start Ceph and mount Ceph at the client. But the problem
is, the mounted point always fail with an infinite response time
(after I mount Ceph for about 1 min or less). To illustrate it better,
I will show you the information I got on the client and mds0 machines:

mds0 (192.168.89.133):
debian:~# mkcephfs -c /etc/ceph/ceph.conf --allhosts -v
(A lot of info)
debian:~# /etc/init.d/ceph -a start
(some info)

client (192.168.89.131):
debian:~# mount -t ceph 192.168.89.133:/ /ceph
debian:~# cd /ceph
debian:/ceph# cp ~/app_ch.xls .
debian:/ceph# ls
(waiting for ever)
^C

After the failure I ran dmesg at the client side and got:
client (192.168.89.131):
debian:/ceph# dmesg -c
[  636.664425] ceph: loaded (mon/mds/osd proto 15/32/24, osdmap 5/5 5/5)
[  636.694973] ceph: client4100 fsid 423ad64c-bbf0-3011-bb47-36a89f8787c6
[  636.700716] ceph: mon0 192.168.89.133:6789 session established
[  664.114551] ceph: mds0 192.168.89.133:6800 socket closed
[  664.848722] ceph: mds0 192.168.89.133:6800 socket closed
[  665.914923] ceph: mds0 192.168.89.133:6800 socket closed
[  667.840396] ceph: mds0 192.168.89.133:6800 socket closed
[  672.054106] ceph: mds0 192.168.89.133:6800 socket closed
[  680.894531] ceph: mds0 192.168.89.133:6800 socket closed
[  696.928496] ceph: mds0 192.168.89.133:6800 socket closed
[  720.171754] ceph: mds0 caps stale
[  728.999701] ceph: mds0 192.168.89.133:6800 socket closed
[  794.640943] ceph: mds0 192.168.89.133:6800 socket closed

Immediately after the failure, I ran netstat at mds0:
mds0 (192.168.89.133):
debian:~# netstat -anp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address
State       PID/Program name
tcp        0      0 0.0.0.0:6800            0.0.0.0:*
LISTEN      1889/cmds
tcp        0      0 0.0.0.0:22              0.0.0.0:*
LISTEN      1529/sshd
tcp        0      0 192.168.89.133:6789     0.0.0.0:*
LISTEN      1840/cmon
tcp        0      0 192.168.89.133:6789     192.168.89.131:56855
ESTABLISHED 1840/cmon
tcp        0      0 192.168.89.133:43647    192.168.89.133:6789
ESTABLISHED 1889/cmds
tcp        0      0 192.168.89.133:22       192.168.89.1:58304
ESTABLISHED 1530/0
tcp        0      0 192.168.89.133:39826    192.168.89.134:6800
ESTABLISHED 1889/cmds
tcp        0      0 192.168.89.133:6789     192.168.89.134:41289
ESTABLISHED 1840/cmon
tcp        0      0 192.168.89.133:6800     192.168.89.131:52814
TIME_WAIT   -
tcp        0      0 192.168.89.133:6789     192.168.89.135:41021
ESTABLISHED 1840/cmon
tcp        0      0 192.168.89.133:42069    192.168.89.135:6800
ESTABLISHED 1889/cmds
tcp        0      0 192.168.89.133:6789     192.168.89.133:43647
ESTABLISHED 1840/cmon
tcp        0      0 192.168.89.133:6800     192.168.89.131:52815
TIME_WAIT   -
tcp        0      0 192.168.89.133:6800     192.168.89.131:52816
TIME_WAIT   -
tcp6       0      0 :::22                   :::*
LISTEN      1529/sshd
udp        0      0 0.0.0.0:68              0.0.0.0:*
         1490/dhclient3
Active UNIX domain sockets (servers and established)
Proto RefCnt Flags       Type       State         I-Node   PID/Program
name    Path
unix  2      [ ]         DGRAM                    2972     546/udevd
        @/org/kernel/udev/udevd
unix  4      [ ]         DGRAM                    5343
1358/rsyslogd       /dev/log
unix  2      [ ]         DGRAM                    5662     1530/0
unix  2      [ ]         DGRAM                    5486     1490/dhclient3
debian:~#
debian:~# dmesg -c
debian:~# (nothing shows up)

I saw the port 6800 on the metadata server talking with the client is
on "TIME_WAIT" stage. That means the connection is closed.
This is the ceph.conf I have:
[global]
       pid file = /var/run/ceph/$type.$id.pid
[mon]
       mon data = /data/mon$id
       mon subscribe interval = 6000
       mon osd down out interval = 6000
[mon0]
       host = mds0
       mon addr = 192.168.89.133:6789
[mds]
       mds session timeout = 6000
       mds session autoclose = 6000
       mds client lease = 6000
       keyring = /data/keyring.$name
[mds0]
       host = mds0
[osd]
       sudo = true
       osd data = /data/osd$id
       osd journal = /journal
       osd journal size = 1024
       filestore journal writeahead = true
[osd0]
       host = osd0
[osd1]
       host = osd1
[group everyone]
       addr = 0.0.0.0/0
[mount]
       allow = %everyone
;-----------------------------------end-----------------------------------

The Ceph version I was using is 0.22.1.

Can anyone help me to solve this problem? Thanks in advance!
