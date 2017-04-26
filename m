From: Jerry Lee <leisurelysw24@gmail.com>
Subject: repeating "wrong node" and ceph-mgr CPU usage get higher and higher
 without any I/O
Date: Wed, 26 Apr 2017 18:51:19 +0800
Message-ID: <CAKQB+fubL9-JNyD-1xR9w_u=-hW2e4CJNOaiVjOJQWJHi=SsWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34229 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2997087AbdDZKvV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Apr 2017 06:51:21 -0400
Received: by mail-lf0-f51.google.com with SMTP id t144so105680175lff.1
        for <ceph-devel@vger.kernel.org>; Wed, 26 Apr 2017 03:51:20 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, haomaiwang@gmail.com

Hi,

I got a issue that the ceph-mgr consumes more and more CPU computing
power even when there's no I/O in my cluster.  Some logs and strace
output are provided as follows.  From the logs, it seems that the
"wrong node" log starts appearing when a node leave and rejoin the
cluster.  The question is why does ceph-mgr keeps trying the old
connections even after it knows the new (correct) nonce already? And
the number of trial connections is also increasing as time go on.  The
only way to mitigate the issue is to restart the ceph-mgr process, but
after several hours, the issue occurs again.  Is there any suggestion
or idea that I could do to solve the issue?  Thanks!


environment:
=========
linux-4.2.8
ceph version v11.0.2
8 nodes and 8 8TB disks on each nodes.
   - 3 MONs
   - 3 MGRs
   - 3 MDSs

parts of ceph-mgr log:
================
2017-04-25 12:27:23.298417 7f2b74d31700  0 -- 192.168.2.8:6849/3516 >>
192.168.2.7:0/3459516139 conn(0x55b915d77800 :6849 s=STATE_OPEN pgs=2
cs=1 l=0).fault initiating reconnect
2017-04-25 12:27:23.480121 7f2b74530700  0 -- 192.168.2.8:6849/3516 >>
192.168.2.7:0/1237847161 conn(0x55b915d79000 :6849 s=STATE_OPEN pgs=2
cs=1 l=0).fault initiating reconnect
2017-04-25 12:27:23.614977 7f2b75532700  0 -- 192.168.2.8:6849/3516 >>
192.168.2.7:0/2251622435 conn(0x55b915d7a800 :6849 s=STATE_OPEN pgs=2
cs=1 l=0).fault initiating reconnect
...
2017-04-25 14:21:54.632838 7f2b74530700  0 -- 192.168.2.8:6849/3516 >>
192.168.2.6:6824/3898 conn(0x55b914c7a000 :6849
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=2 cs=2
l=0)._process_connection connect claims to be 192.168.2.6:6824/3683
not 192.168.2.6:6824/3898 - wrong node!
2017-04-25 14:21:54.824814 7f2b74530700  0 -- 192.168.2.8:6849/3516 >>
192.168.2.6:6812/3552 conn(0x55b914c4e000 :6849
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=2 cs=2
l=0)._process_connection connect claims to be 192.168.2.6:6812/3467
not 192.168.2.6:6812/3552 - wrong node!
2017-04-25 14:21:55.240852 7f2b75532700  0 -- 192.168.2.8:6849/3516 >>
192.168.2.6:6836/4430 conn(0x55b914413000 :6849
s=STATE_CONNECTING_WAIT_BANNER_AND_IDENTIFY pgs=2 cs=2
l=0)._process_connection connect claims to be 192.168.2.6:6836/3978
not 192.168.2.6:6836/4430 - wrong node!

strace output:
==========
[BEFORE]
# timeout 10 ./strace -p 3518 -c
./strace: Process 3518 attached
./strace: Process 3518 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 96.91    0.282674          15     19033           epoll_wait
  0.95    0.002783           2      1662         7 futex
  0.58    0.001682           2       902       892 connect
  0.54    0.001581           4       381        78 read
  0.27    0.000774           1       912           epoll_ctl
  0.19    0.000563           7        79           sendmsg
  0.14    0.000409           1       329           close
  0.14    0.000398           1       329           socket
  0.12    0.000364           1       658           fcntl
  0.08    0.000247           1       329       319 shutdown
  0.08    0.000224           1       329           setsockopt
------ ----------- ----------- --------- --------- ----------------
100.00    0.291699                 24943      1296 total

[AFTER about 1 day]
# timeout 10 ./strace -p 3518 -c
./strace: Process 3518 attached
./strace: Process 3518 detached
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 99.91    0.403715           2    199589           epoll_wait
  0.05    0.000218           0     18739     18739 connect
  0.02    0.000075           0     32176       169 futex
  0.01    0.000024           0      6486           socket
  0.00    0.000020           0     12972           fcntl
  0.00    0.000018           0     18739           epoll_ctl
  0.00    0.000010           0      6486           setsockopt
  0.00    0.000006           0      6486           close
  0.00    0.000005           0      6486      6486 shutdown
  0.00    0.000000           0       304        51 read
  0.00    0.000000           0        51           sendmsg
------ ----------- ----------- --------- --------- ----------------
100.00    0.404091                308514     25445 total

detailed strace result on a ceph-mgr:
==========================
socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 94
fcntl(94, F_GETFL)                      = 0x2 (flags O_RDWR)
fcntl(94, F_SETFL, O_RDWR|O_NONBLOCK)   = 0
setsockopt(94, SOL_TCP, TCP_NODELAY, [1], 4) = 0
connect(94, {sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.2.7")}, 16) = -1 EINPROGRESS (Operation
now in progress)
epoll_ctl(4, EPOLL_CTL_ADD, 94, {EPOLLIN|EPOLLET, {u32=94, u64=94}}) = 0
connect(94, {sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.2.7")}, 16) = -1 EALREADY (Operation
already in progress)
epoll_ctl(4, EPOLL_CTL_MOD, 94, {EPOLLIN|EPOLLOUT|EPOLLET, {u32=94,
u64=94}}) = 0
epoll_wait(4, [{EPOLLIN|EPOLLOUT|EPOLLERR|EPOLLHUP, {u32=95, u64=95}},
{EPOLLIN|EPOLLOUT|EPOLLERR|EPOLLHUP, {u32=93, u64=93}}], 5000, 4) = 2
connect(95, {sa_family=AF_INET, sin_port=htons(0),
sin_addr=inet_addr("192.168.2.2")}, 16) = -1 ECONNREFUSED (Connection
refused)
