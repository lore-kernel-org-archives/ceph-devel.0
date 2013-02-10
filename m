From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: OSD down
Date: Sun, 10 Feb 2013 18:45:34 +0100
Message-ID: <1360518334.17404.30.camel@boolette.noo>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:39364 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab3BJRvz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 Feb 2013 12:51:55 -0500
Received: from luuna.daevel.fr ([82.67.37.138] helo=[192.168.1.50])
	by licorne.daevel.fr with esmtpsa (SSL3.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <ceph.list@daevel.fr>)
	id 1U4ay7-0002RF-HT
	for ceph-devel@vger.kernel.org; Sun, 10 Feb 2013 18:45:35 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have an OSD which often stopped (ceph 0.56.2), with that in logs :

446 stamp 2013-02-10 18:37:27.559777) v2 ==== 47+0+0 (4068038983 0 0)
0x11e028c0 con 0x573d6e0
    -3> 2013-02-10 18:37:27.561618 7f1c765d5700  1 --
192.168.42.1:0/5824 <== osd.31 192.168.42.3:6811/23050 129 ====
osd_ping(ping_reply e13446 stamp 2013-02-10 18:37:27.559777) v2 ==== 47
+0+0 (4068038983 0 0) 0x73be380 con 0x573d420
    -2> 2013-02-10 18:37:27.562674 7f1c765d5700  1 --
192.168.42.1:0/5824 <== osd.1 192.168.42.2:6803/7458 129 ====
osd_ping(ping_reply e13446 stamp 2013-02-10 18:37:27.559777) v2 ==== 47
+0+0 (4068038983 0 0) 0x6bd8a80 con 0x573dc60
    -1> 2013-02-10 18:37:28.217626 7f1c805e9700  5 osd.12 13444 tick
     0> 2013-02-10 18:37:28.552692 7f1c725cd700 -1 os/FileStore.cc: In
function 'virtual int FileStore::read(coll_t, const hobject_t&,
uint64_t, size_t, ceph::bufferlist&)' thread 7f1c725cd700 time
2013-02-10 18:37:28.537715
os/FileStore.cc: 2732: FAILED assert(!m_filestore_fail_eio || got != -5)

 ceph version  ()
 1: (FileStore::read(coll_t, hobject_t const&, unsigned long, unsigned
long, ceph::buffer::list&)+0x462) [0x725f92]
 2: (PG::_scan_list(ScrubMap&, std::vector<hobject_t,
std::allocator<hobject_t> >&, bool)+0x371) [0x685da1]
 3: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t,
bool)+0x29b) [0x6866bb]
 4: (PG::replica_scrub(MOSDRepScrub*)+0x8e9) [0x6952b9]
 5: (OSD::RepScrubWQ::_process(MOSDRepScrub*)+0xc2) [0x6410a2]
 6: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x80f9e9]
 7: (ThreadPool::WorkThread::entry()+0x10) [0x8121f0]
 8: (()+0x68ca) [0x7f1c852f48ca]
 9: (clone()+0x6d) [0x7f1c83e23b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

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
  max_recent    100000
  max_new         1000
  log_file /var/log/ceph/osd.12.log
--- end dump of recent events ---
2013-02-10 18:37:29.236649 7f1c725cd700 -1 *** Caught signal (Aborted)
**
 in thread 7f1c725cd700

 ceph version  ()
 1: /usr/bin/ceph-osd() [0x7a0db9]
 2: (()+0xeff0) [0x7f1c852fcff0]
 3: (gsignal()+0x35) [0x7f1c83d861b5]
 4: (abort()+0x180) [0x7f1c83d88fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f1c8461adc5]
 6: (()+0xcb166) [0x7f1c84619166]
 7: (()+0xcb193) [0x7f1c84619193]
 8: (()+0xcb28e) [0x7f1c8461928e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x7c9) [0x8f3fc9]
 10: (FileStore::read(coll_t, hobject_t const&, unsigned long, unsigned
long, ceph::buffer::list&)+0x462) [0x725f92]
 11: (PG::_scan_list(ScrubMap&, std::vector<hobject_t,
std::allocator<hobject_t> >&, bool)+0x371) [0x685da1]
 12: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t,
bool)+0x29b) [0x6866bb]
 13: (PG::replica_scrub(MOSDRepScrub*)+0x8e9) [0x6952b9]
 14: (OSD::RepScrubWQ::_process(MOSDRepScrub*)+0xc2) [0x6410a2]
 15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x80f9e9]
 16: (ThreadPool::WorkThread::entry()+0x10) [0x8121f0]
 17: (()+0x68ca) [0x7f1c852f48ca]
 18: (clone()+0x6d) [0x7f1c83e23b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
    -1> 2013-02-10 18:37:29.217778 7f1c805e9700  5 osd.12 13444 tick
     0> 2013-02-10 18:37:29.236649 7f1c725cd700 -1 *** Caught signal
(Aborted) **
 in thread 7f1c725cd700

 ceph version  ()
 1: /usr/bin/ceph-osd() [0x7a0db9]
 2: (()+0xeff0) [0x7f1c852fcff0]
 3: (gsignal()+0x35) [0x7f1c83d861b5]
 4: (abort()+0x180) [0x7f1c83d88fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f1c8461adc5]
 6: (()+0xcb166) [0x7f1c84619166]
 7: (()+0xcb193) [0x7f1c84619193]
 8: (()+0xcb28e) [0x7f1c8461928e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x7c9) [0x8f3fc9]
 10: (FileStore::read(coll_t, hobject_t const&, unsigned long, unsigned
long, ceph::buffer::list&)+0x462) [0x725f92]
 11: (PG::_scan_list(ScrubMap&, std::vector<hobject_t,
std::allocator<hobject_t> >&, bool)+0x371) [0x685da1]
 12: (PG::build_scrub_map_chunk(ScrubMap&, hobject_t, hobject_t,
bool)+0x29b) [0x6866bb]
 13: (PG::replica_scrub(MOSDRepScrub*)+0x8e9) [0x6952b9]
 14: (OSD::RepScrubWQ::_process(MOSDRepScrub*)+0xc2) [0x6410a2]
 15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x879) [0x80f9e9]
 16: (ThreadPool::WorkThread::entry()+0x10) [0x8121f0]
 17: (()+0x68ca) [0x7f1c852f48ca]
 18: (clone()+0x6d) [0x7f1c83e23b6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

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
  max_recent    100000
  max_new         1000
  log_file /var/log/ceph/osd.12.log
--- end dump of recent events ---



What should I do ?



