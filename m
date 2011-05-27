From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: OSD crash
Date: Fri, 27 May 2011 19:41:50 +0300
Message-ID: <4DDFD44E.8070305@ufm.su>
References: <4DDEEC7C.8060800@ufm.su> <BANLkTimxRbM95_LMJwAa+oUwj-HAePJM+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:40022 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754322Ab1E0Qlw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 27 May 2011 12:41:52 -0400
In-Reply-To: <BANLkTimxRbM95_LMJwAa+oUwj-HAePJM+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/27/2011 06:16 PM, Gregory Farnum wrote:
> This is an interesting one -- the invariant that assert is checking
> isn't too complicated (that the object lives on the RecoveryWQ's
> queue) and seems to hold everywhere the RecoveryWQ is called. And the
> functions modifying the queue are always called under the workqueue
> lock, and do maintenance if the xlist::item is on a different list.
> Which makes me think that the problem must be from conflating the
> RecoveryWQ lock and the PG lock in the few places that modify the
> PG::recovery_item directly, rather than via RecoveryWQ functions.
> Anybody more familiar than me with this have ideas?
> Fyodor, based on the time stamps and output you've given us, I assume
> you don't have more detailed logs?
> -Greg

Greg, i got this crash again.
Let me tell you the configuration and what is happening:
Configuration:
6 osd servers. 4G RAM, 4*1T hdd (mdadmed to raid0), 2*1G etherchannel 
ethernet, Ubuntu server 11.04/64  with kernel 2.6.39 (hand compiled)
mon+mds server 24G RAM, the same os.

On each OSD Journal placed on 1G tempfs. OSD data - on xfs in this case.

Configuration file:

[global]
         max open files = 131072
         log file = /var/log/ceph/$name.log
         pid file = /var/run/ceph/$name.pid

[mon]
         mon data = /mfs/mon$id

[mon.0]
         mon addr  = 10.5.51.230:6789

[mds]
         keyring = /mfs/mds/keyring.$name

[mds.0]
         host = mds0


[osd]
         osd data = /$name
         osd journal = /journal/$name
         osd journal size = 950
         journal dio = false

[osd.0]
         host = osd0
         cluster addr = 10.5.51.10
         public addr = 10.5.51.140

[osd.1]
         host = osd1
         cluster addr = 10.5.51.11
         public addr = 10.5.51.141

[osd.2]
         host = osd2
         cluster addr = 10.5.51.12
         public addr = 10.5.51.142

[osd.3]
         host = osd3
         cluster addr = 10.5.51.13
         public addr = 10.5.51.143

[osd.4]
         host = osd4
         cluster addr = 10.5.51.14
         public addr = 10.5.51.144

[osd.5]
         host = osd5
         cluster addr = 10.5.51.15
         public addr = 10.5.51.145

What happening:
osd2 was crashed, rebooted, osd data and journal created from scratch by 
"cosd --mkfs -i 2 --monmap /tmp/monmap" and server started.
Additional - on osd2 enables "writeahaed", but I think it's not 
principal in this case.

Well, server start rebalancing:

2011-05-27 15:12:49.323558 7f3b69de5740 ceph version 0.28.1.commit: 
d66c6ca19bbde3c363b135b66072de44e67c6632. process: cosd. pid: 1694
2011-05-27 15:12:49.325331 7f3b69de5740 filestore(/osd.2) mount FIEMAP 
ioctl is NOT supported
2011-05-27 15:12:49.325378 7f3b69de5740 filestore(/osd.2) mount did NOT 
detect btrfs
2011-05-27 15:12:49.325467 7f3b69de5740 filestore(/osd.2) mount found 
snaps <>
2011-05-27 15:12:49.325512 7f3b69de5740 filestore(/osd.2) mount: 
WRITEAHEAD journal mode explicitly enabled in conf
2011-05-27 15:12:49.325526 7f3b69de5740 filestore(/osd.2) mount WARNING: 
not btrfs or ext3; data may be lost
2011-05-27 15:12:49.325606 7f3b69de5740 journal _open /journal/osd.2 fd 
11: 996147200 bytes, block size 4096 bytes, directio = 0
2011-05-27 15:12:49.325641 7f3b69de5740 journal read_entry 4096 : seq 1 
203 bytes
2011-05-27 15:12:49.325698 7f3b69de5740 journal _open /journal/osd.2 fd 
11: 996147200 bytes, block size 4096 bytes, directio = 0
2011-05-27 15:12:49.544716 7f3b59656700 -- 10.5.51.12:6801/1694 >> 
10.5.51.14:6801/5070 pipe(0x1239d20 sd=27 pgs=0 cs=0 l=0).accept we 
reset (peer sent cseq 2), sending RESETSESSION
2011-05-27 15:12:49.544798 7f3b59c5c700 -- 10.5.51.12:6801/1694 >> 
10.5.51.13:6801/5165 pipe(0x104b950 sd=14 pgs=0 cs=0 l=0).accept we 
reset (peer sent cseq 2), sending RESETSESSION
2011-05-27 15:12:49.544864 7f3b59757700 -- 10.5.51.12:6801/1694 >> 
10.5.51.15:6801/1574 pipe(0x11e7cd0 sd=16 pgs=0 cs=0 l=0).accept we 
reset (peer sent cseq 2), sending RESETSESSION
2011-05-27 15:12:49.544909 7f3b59959700 -- 10.5.51.12:6801/1694 >> 
10.5.51.10:6801/6148 pipe(0x11d7d30 sd=15 pgs=0 cs=0 l=0).accept we 
reset (peer sent cseq 2), sending RESETSESSION
2011-05-27 15:13:23.015637 7f3b64579700 journal check_for_full at 
66404352 : JOURNAL FULL 66404352 >= 851967 (max_size 996147200 start 
67256320)
2011-05-27 15:13:25.586081 7f3b5dc6b700 journal throttle: waited for bytes
2011-05-27 15:13:25.601789 7f3b5d46a700 journal throttle: waited for bytes

[...] and after 2 hours:

2011-05-27 17:30:21.355034 7f3b64579700 journal check_for_full at 
415199232 : JOURNAL FULL 415199232 >= 778239 (max_size 996147200 start 
415977472)
2011-05-27 17:30:23.441445 7f3b5d46a700 journal throttle: waited for bytes
2011-05-27 17:30:36.362877 7f3b64579700 journal check_for_full at 
414326784 : JOURNAL FULL 414326784 >= 872447 (max_size 996147200 start 
415199232)
2011-05-27 17:30:38.391372 7f3b5d46a700 journal throttle: waited for bytes
2011-05-27 17:30:50.373936 7f3b64579700 journal check_for_full at 
414314496 : JOURNAL FULL 414314496 >= 12287 (max_size 996147200 start 
414326784)
./include/xlist.h: In function 'void xlist<T>::remove(xlist<T>::item*) 
[with T = PG*]', in thread '0x7f3b5cc69700'
./include/xlist.h: 107: FAILED assert(i->_list == this)
  ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6632)
  1: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
  2: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
  3: (ThreadPool::worker()+0x10a) [0x65799a]
  4: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
  5: (()+0x6d8c) [0x7f3b697b5d8c]
  6: (clone()+0x6d) [0x7f3b6866804d]
  ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6632)
  1: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
  2: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
  3: (ThreadPool::worker()+0x10a) [0x65799a]
  4: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
  5: (()+0x6d8c) [0x7f3b697b5d8c]
  6: (clone()+0x6d) [0x7f3b6866804d]
*** Caught signal (Aborted) **
  in thread 0x7f3b5cc69700
  ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6632)
  1: /usr/bin/cosd() [0x6729f9]
  2: (()+0xfc60) [0x7f3b697bec60]
  3: (gsignal()+0x35) [0x7f3b685b5d05]
  4: (abort()+0x186) [0x7f3b685b9ab6]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f3b68e6c6dd]
  6: (()+0xb9926) [0x7f3b68e6a926]
  7: (()+0xb9953) [0x7f3b68e6a953]
  8: (()+0xb9a5e) [0x7f3b68e6aa5e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x362) [0x655e32]
  10: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
  11: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
  12: (ThreadPool::worker()+0x10a) [0x65799a]
  13: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
  14: (()+0x6d8c) [0x7f3b697b5d8c]
  15: (clone()+0x6d) [0x7f3b6866804d]

I.e. it's not "easy reproduced" bug. While I had less data in the 
cluster - I not seen this error.

I think that I do not have enough space for "full" log for 2-3 hours. Sorry.

WBR,
     Fyodor.

