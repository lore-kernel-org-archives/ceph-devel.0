From: James Harper <james.harper@bendigoit.com.au>
Subject: mon crash
Date: Wed, 19 Jun 2013 09:53:09 +0000
Message-ID: <6035A0D088A63A46850C3988ED045A4B5C2183F2@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.bendigoit.com.au ([203.16.224.4]:56138 "EHLO
	smtp1.bendigoit.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933873Ab3FSJxi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 05:53:38 -0400
Received: from smtp2.bendigoit.com.au ([203.16.207.99] helo=BITCOM1.int.sbss.com.au)
	by smtp1.bendigoit.com.au with esmtp (Exim 4.69)
	(envelope-from <james.harper@bendigoit.com.au>)
	id 1UpF53-00053k-U1
	for ceph-devel@vger.kernel.org; Wed, 19 Jun 2013 19:53:34 +1000
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Every time I start up one of my mons it crashes. Two others are running but there seems to be long delays (=several seconds) when doing mon status (maybe this is the behaviour when one mon is down?)

The tail of /var/log/ceph/ceph-mon.4.log follows this email.

Version is 0.61.3-1~bpo70+1 from http://ceph.com/debian-cuttlefish wheezy main

This was happening in a previous version, and then even before that but I thought I'd fixed it by wiping the errant mon and recreating it.

Anything else I can supply that might help?

Thanks

James

     0> 2013-06-19 19:45:44.018695 7f472d995700 -1 mon/Monitor.cc: In function 'void Monitor::sync_timeout(entity_inst_t&)' thread 7f472d995700 time 2013-06-19 19:45:44.017928
mon/Monitor.cc: 1101: FAILED assert(sync_state == SYNC_STATE_CHUNKS)

 ceph version 0.61.3 (92b1e398576d55df8e5888dd1a9545ed3fd99532)
 1: /usr/bin/ceph-mon() [0x4c8eca]
 2: (Context::complete(int)+0xa) [0x4d70fa]
 3: (SafeTimer::timer_thread()+0x1af) [0x64ad4f]
 4: (SafeTimerThread::entry()+0xd) [0x64c3dd]
 5: (()+0x6b50) [0x7f47c0c3ab50]
 6: (clone()+0x6d) [0x7f47bf39ba7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-mon.4.log
--- end dump of recent events ---
2013-06-19 19:45:44.036036 7f472d995700 -1 *** Caught signal (Aborted) **
 in thread 7f472d995700

 ceph version 0.61.3 (92b1e398576d55df8e5888dd1a9545ed3fd99532)
 1: /usr/bin/ceph-mon() [0x5a08b2]
 2: (()+0xf030) [0x7f47c0c43030]
 3: (gsignal()+0x35) [0x7f47bf2f3475]
 4: (abort()+0x180) [0x7f47bf2f66f0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f47bfb4889d]
 6: (()+0x63996) [0x7f47bfb46996]
 7: (()+0x639c3) [0x7f47bfb469c3]
 8: (()+0x63bee) [0x7f47bfb46bee]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x40a) [0x65418a]
 10: /usr/bin/ceph-mon() [0x4c8eca]
 11: (Context::complete(int)+0xa) [0x4d70fa]
 12: (SafeTimer::timer_thread()+0x1af) [0x64ad4f]
 13: (SafeTimerThread::entry()+0xd) [0x64c3dd]
 14: (()+0x6b50) [0x7f47c0c3ab50]
 15: (clone()+0x6d) [0x7f47bf39ba7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
     0> 2013-06-19 19:45:44.036036 7f472d995700 -1 *** Caught signal (Aborted) **
 in thread 7f472d995700

 ceph version 0.61.3 (92b1e398576d55df8e5888dd1a9545ed3fd99532)
 1: /usr/bin/ceph-mon() [0x5a08b2]
 2: (()+0xf030) [0x7f47c0c43030]
 3: (gsignal()+0x35) [0x7f47bf2f3475]
 4: (abort()+0x180) [0x7f47bf2f66f0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f47bfb4889d]
 6: (()+0x63996) [0x7f47bfb46996]
 7: (()+0x639c3) [0x7f47bfb469c3]
 8: (()+0x63bee) [0x7f47bfb46bee]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x40a) [0x65418a]
 10: /usr/bin/ceph-mon() [0x4c8eca]
 11: (Context::complete(int)+0xa) [0x4d70fa]
 12: (SafeTimer::timer_thread()+0x1af) [0x64ad4f]
 13: (SafeTimerThread::entry()+0xd) [0x64c3dd]
 14: (()+0x6b50) [0x7f47c0c3ab50]
 15: (clone()+0x6d) [0x7f47bf39ba7d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 1 buffer
   0/ 1 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 5 ms
   1/ 5 mon
   0/10 monc
   0/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-mon.4.log
--- end dump of recent events ---
