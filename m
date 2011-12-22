From: Martin Mailand <martin@tuxadero.com>
Subject: Assertion: ./messages/MOSDRepScrub.h: 64: FAILED assert(v == 0)
Date: Thu, 22 Dec 2011 14:48:10 +0100
Message-ID: <4EF3351A.5050404@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:60952 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1LVNsM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 08:48:12 -0500
Received: from [172.30.1.184] ([192.166.201.59])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBMDmAMO015046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 22 Dec 2011 14:48:11 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi
today 2 of my osds (osd.4 and osd.7) crashed with the same error.

2011-12-21 14:41:18.896008 7fae9f3a5700 journal check_for_full at 
80625664 : JOURNAL FULL 80625664 >= 368639 (max_size 107372544 start 
80994304)
2011-12-21 14:41:23.205993 7fae9fba6700 journal  FULL_FULL -> FULL_WAIT. 
  last commit epoch committed, waiting for a new one to start.
2011-12-21 14:41:24.075990 7fae9fba6700 journal  FULL_WAIT -> 
FULL_NOTFULL.  journal now active, setting completion plug.
./messages/MOSDRepScrub.h: In function 'virtual void 
MOSDRepScrub::decode_payload(CephContext*)', in thread '7fae93977700'
./messages/MOSDRepScrub.h: 64: FAILED assert(v == 0)
  ceph version 0.39-171-gdcedda8 
(commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
  1: /usr/bin/ceph-osd() [0x685e77]
  2: (decode_message(CephContext*, ceph_msg_header&, ceph_msg_footer&, 
ceph::buffer::list&, ceph::buffer::list&, ceph::buffer::list&)+0xcd2) 
[0x6a7202]
  3: (SimpleMessenger::Pipe::read_message(Message**)+0x136d) [0x62c9cd]
  4: (SimpleMessenger::Pipe::reader()+0xb99) [0x6357d9]
  5: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x4c244d]
  6: (()+0x6d8c) [0x7faea6873d8c]
  7: (clone()+0x6d) [0x7faea4eb004d]
  ceph version 0.39-171-gdcedda8 
(commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
  1: /usr/bin/ceph-osd() [0x685e77]
  2: (decode_message(CephContext*, ceph_msg_header&, ceph_msg_footer&, 
ceph::buffer::list&, ceph::buffer::list&, ceph::buffer::list&)+0xcd2) 
[0x6a7202]
  3: (SimpleMessenger::Pipe::read_message(Message**)+0x136d) [0x62c9cd]
  4: (SimpleMessenger::Pipe::reader()+0xb99) [0x6357d9]
  5: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x4c244d]
  6: (()+0x6d8c) [0x7faea6873d8c]
  7: (clone()+0x6d) [0x7faea4eb004d]
*** Caught signal (Aborted) **
  in thread 7fae93977700
  ceph version 0.39-171-gdcedda8 
(commit:dcedda84d0e1f69af985c301276c67c1b11e7efc)
  1: /usr/bin/ceph-osd() [0x645172]
  2: (()+0xfc60) [0x7faea687cc60]
  3: (gsignal()+0x35) [0x7faea4dfdd05]
  4: (abort()+0x186) [0x7faea4e01ab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7faea56b46dd]
  6: (()+0xb9926) [0x7faea56b2926]
  7: (()+0xb9953) [0x7faea56b2953]
  8: (()+0xb9a5e) [0x7faea56b2a5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x396) [0x6193d6]
  10: /usr/bin/ceph-osd() [0x685e77]
  11: (decode_message(CephContext*, ceph_msg_header&, ceph_msg_footer&, 
ceph::buffer::list&, ceph::buffer::list&, ceph::buffer::list&)+0xcd2) 
[0x6a7202]
  12: (SimpleMessenger::Pipe::read_message(Message**)+0x136d) [0x62c9cd]
  13: (SimpleMessenger::Pipe::reader()+0xb99) [0x6357d9]
  14: (SimpleMessenger::Pipe::Reader::entry()+0xd) [0x4c244d]
  15: (()+0x6d8c) [0x7faea6873d8c]
  16: (clone()+0x6d) [0x7faea4eb004d]


(gdb) thread apply all bt

<snip>

Thread 1 (Thread 2400):
#0  0x00007faea687cb3b in raise () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x0000000000644dc2 in reraise_fatal (signum=6) at 
global/signal_handler.cc:59
#2  0x00000000006453ba in handle_fatal_signal (signum=6) at 
global/signal_handler.cc:106
#3  <signal handler called>
---Type <return> to continue, or q <return> to quit---
#4  0x00007faea4dfdd05 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#5  0x00007faea4e01ab6 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#6  0x00007faea56b46dd in __gnu_cxx::__verbose_terminate_handler() () 
from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#7  0x00007faea56b2926 in ?? () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#8  0x00007faea56b2953 in std::terminate() () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#9  0x00007faea56b2a5e in __cxa_throw () from 
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
#10 0x00000000006193d6 in ceph::__ceph_assert_fail (assertion=<value 
optimized out>, file=<value optimized out>, line=<value optimized out>,
     func=<value optimized out>) at common/assert.cc:70
#11 0x0000000000685e77 in MOSDRepScrub::decode_payload (this=0x33c0c40, 
cct=<value optimized out>) at ./messages/MOSDRepScrub.h:64
#12 0x00000000006a7202 in decode_message (cct=0x2722000, header=..., 
footer=<value optimized out>, front=<value optimized out>, middle=<value 
optimized out>,
     data=...) at msg/Message.cc:551
#13 0x000000000062c9cd in SimpleMessenger::Pipe::read_message 
(this=0x2ed3780, pm=0x7fae93976d88) at msg/SimpleMessenger.cc:1987
#14 0x00000000006357d9 in SimpleMessenger::Pipe::reader (this=0x2ed3780) 
at msg/SimpleMessenger.cc:1601
#15 0x00000000004c244d in SimpleMessenger::Pipe::Reader::entry 
(this=<value optimized out>) at msg/SimpleMessenger.h:208
#16 0x00007faea6873d8c in start_thread () from 
/lib/x86_64-linux-gnu/libpthread.so.0
#17 0x00007faea4eb004d in clone () from /lib/x86_64-linux-gnu/libc.so.6
#18 0x0000000000000000 in ?? ()
(gdb) thread 1
[Switching to thread 1 (Thread 2400)]#0  0x00007faea687cb3b in raise () 
from /lib/x86_64-linux-gnu/libpthread.so.0
(gdb) frame 11
#11 0x0000000000685e77 in MOSDRepScrub::decode_payload (this=0x33c0c40, 
cct=<value optimized out>) at ./messages/MOSDRepScrub.h:64
64      ./messages/MOSDRepScrub.h: No such file or directory.
         in ./messages/MOSDRepScrub.h
(gdb) p v
$1 = 1 '\001'


-martin
