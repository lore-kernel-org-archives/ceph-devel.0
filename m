From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: OSD crashed today in os/JournalingObjectStore.cc
Date: Wed, 05 Dec 2012 10:56:19 +0100
Message-ID: <50BF1A43.4060605@profihost.ag>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010703020706040003050105"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:44312 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab2LEJ42 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 04:56:28 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------010703020706040003050105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello list,

i updated to latest next from today and then after 20 minutes an OSD was 
crashing in os/JournalingObjectStore.cc.

Attached is the log.

Greets,
Stefan

--------------010703020706040003050105
Content-Type: text/x-log;
 name="ceph-osd.43.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-osd.43.log"

2012-12-05 10:21:12.591166 7f57aeeb9700  0 monclient: hunting for new mon
2012-12-05 10:21:14.338644 7f578e966700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.100:6802/28708 pipe(0xe061000 sd=67 :34107 pgs=50 cs=13 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:14.338786 7f57c6368700  0 -- 10.255.0.103:0/15121 >> 10.255.0.100:6803/28708 pipe(0xd56e900 sd=28 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:15.748915 7f578eb68700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.100:6808/29075 pipe(0xddd1480 sd=74 :6807 pgs=46 cs=27 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:15.749020 7f578c23f700  0 -- 10.255.0.103:0/15121 >> 10.255.0.100:6809/29075 pipe(0xc96b6c0 sd=47 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:17.029751 7f5789f06700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.100:6811/29438 pipe(0x11ed56c0 sd=75 :6807 pgs=76 cs=21 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:17.029925 7f578be3b700  0 -- 10.255.0.103:0/15121 >> 10.255.0.100:6814/29438 pipe(0xcf876c0 sd=55 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:18.334263 7f578fa77700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.100:6819/29801 pipe(0xd0bb480 sd=79 :6807 pgs=85 cs=43 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:18.334403 7f578a007700  0 -- 10.255.0.103:0/15121 >> 10.255.0.100:6821/29801 pipe(0x12024b40 sd=28 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:20.375215 7f578fb78700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.101:6801/8284 pipe(0xdb0ed80 sd=42 :6807 pgs=39 cs=9 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:20.375381 7f578be3b700  0 -- 10.255.0.103:0/15121 >> 10.255.0.101:6802/8284 pipe(0x100656c0 sd=59 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:22.637693 7f5789a01700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.101:6804/8467 pipe(0x13a23d80 sd=77 :6807 pgs=182 cs=15 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:22.637861 7f578f976700  0 -- 10.255.0.103:0/15121 >> 10.255.0.101:6805/8467 pipe(0xd2dcb40 sd=28 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:24.777204 7f578a108700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.101:6807/8647 pipe(0xd8eeb40 sd=40 :6807 pgs=257 cs=29 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:24.777420 7f578b431700  0 -- 10.255.0.103:0/15121 >> 10.255.0.101:6808/8647 pipe(0xceb3900 sd=74 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:26.870074 7f578f16e700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.101:6810/8877 pipe(0x114a56c0 sd=72 :6807 pgs=200 cs=13 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:26.870281 7f578ce4b700  0 -- 10.255.0.103:0/15121 >> 10.255.0.101:6811/8877 pipe(0xceb3480 sd=51 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:28.977016 7f578f471700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.102:6801/6127 pipe(0xd8ee900 sd=38 :6807 pgs=178 cs=15 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:28.977174 7f578db58700  0 -- 10.255.0.103:0/15121 >> 10.255.0.102:6802/6127 pipe(0xceb36c0 sd=40 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:31.091973 7f578f370700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.102:6806/6308 pipe(0xc96cd80 sd=36 :6807 pgs=260 cs=1 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:31.092196 7f578f16e700  0 -- 10.255.0.103:0/15121 >> 10.255.0.102:6807/6308 pipe(0xdbbc6c0 sd=31 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:33.200579 7f578f26f700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.102:6809/6491 pipe(0xc96cb40 sd=35 :6807 pgs=261 cs=1 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:33.200853 7f578f471700  0 -- 10.255.0.103:0/15121 >> 10.255.0.102:6810/6491 pipe(0xe1cf480 sd=38 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:35.329384 7f578a70e700  0 -- 10.255.0.103:6807/15121 >> 10.255.0.102:6822/6670 pipe(0xfad4b40 sd=70 :6807 pgs=319 cs=9 l=0).fault with nothing to send, going to standby
2012-12-05 10:21:35.329523 7f578d754700  0 -- 10.255.0.103:0/15121 >> 10.255.0.102:6823/6670 pipe(0xfad4240 sd=72 :0 pgs=0 cs=0 l=1).fault
2012-12-05 10:21:42.031928 7f57c26e0700 -1 osd.43 923 *** Got signal Terminated ***
2012-12-05 10:21:42.032002 7f57c26e0700 -1 osd.43 923  pausing thread pools
2012-12-05 10:21:42.032007 7f57c26e0700 -1 osd.43 923  flushing io
2012-12-05 10:21:42.032015 7f57c26e0700 -1 osd.43 923  removing pid file
2012-12-05 10:21:42.032092 7f57c26e0700 -1 osd.43 923  exit
2012-12-05 10:21:43.608251 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is supported and appears to work
2012-12-05 10:21:43.608262 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2012-12-05 10:21:43.608495 7fd046962780  0 filestore(/ceph/osd.43/) mount did NOT detect btrfs
2012-12-05 10:21:43.613072 7fd046962780  0 filestore(/ceph/osd.43/) mount syscall(__NR_syncfs, fd) fully supported
2012-12-05 10:21:43.613151 7fd046962780  0 filestore(/ceph/osd.43/) mount found snaps <>
2012-12-05 10:21:43.615479 7fd046962780  0 filestore(/ceph/osd.43/) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2012-12-05 10:21:43.638102 7fd046962780  0 journal  kernel version is 3.6.7
2012-12-05 10:21:43.768129 7fd046962780  0 journal  kernel version is 3.6.7
2012-12-05 10:21:43.819826 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is supported and appears to work
2012-12-05 10:21:43.819835 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
2012-12-05 10:21:43.820065 7fd046962780  0 filestore(/ceph/osd.43/) mount did NOT detect btrfs
2012-12-05 10:21:43.821567 7fd046962780  0 filestore(/ceph/osd.43/) mount syscall(__NR_syncfs, fd) fully supported
2012-12-05 10:21:43.821622 7fd046962780  0 filestore(/ceph/osd.43/) mount found snaps <>
2012-12-05 10:21:43.822791 7fd046962780  0 filestore(/ceph/osd.43/) mount: enabling WRITEAHEAD journal mode: btrfs not detected
2012-12-05 10:21:43.837954 7fd046962780  0 journal  kernel version is 3.6.7
2012-12-05 10:21:43.898018 7fd046962780  0 journal  kernel version is 3.6.7
2012-12-05 10:46:40.709056 7fd03c4b6700 -1 os/JournalingObjectStore.cc: In function 'uint64_t JournalingObjectStore::ApplyManager::op_apply_start(uint64_t)' thread 7fd03c4b6700 time 2012-12-05 10:46:40.338489
os/JournalingObjectStore.cc: 134: FAILED assert(op > committed_seq)

 ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
 1: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned long)+0x816) [0x747626]
 2: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
 3: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
 4: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
 5: (()+0x68ca) [0x7fd04633f8ca]
 6: (clone()+0x6d) [0x7fd0447aeb6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
   -29> 2012-12-05 10:21:43.592318 7fd046962780  5 asok(0x244b000) register_command perfcounters_dump hook 0x243f010
   -28> 2012-12-05 10:21:43.592340 7fd046962780  5 asok(0x244b000) register_command 1 hook 0x243f010
   -27> 2012-12-05 10:21:43.592342 7fd046962780  5 asok(0x244b000) register_command perf dump hook 0x243f010
   -26> 2012-12-05 10:21:43.592350 7fd046962780  5 asok(0x244b000) register_command perfcounters_schema hook 0x243f010
   -25> 2012-12-05 10:21:43.592354 7fd046962780  5 asok(0x244b000) register_command 2 hook 0x243f010
   -24> 2012-12-05 10:21:43.592357 7fd046962780  5 asok(0x244b000) register_command perf schema hook 0x243f010
   -23> 2012-12-05 10:21:43.592359 7fd046962780  5 asok(0x244b000) register_command config show hook 0x243f010
   -22> 2012-12-05 10:21:43.592361 7fd046962780  5 asok(0x244b000) register_command config set hook 0x243f010
   -21> 2012-12-05 10:21:43.592363 7fd046962780  5 asok(0x244b000) register_command log flush hook 0x243f010
   -20> 2012-12-05 10:21:43.592365 7fd046962780  5 asok(0x244b000) register_command log dump hook 0x243f010
   -19> 2012-12-05 10:21:43.592367 7fd046962780  5 asok(0x244b000) register_command log reopen hook 0x243f010
   -18> 2012-12-05 10:21:43.594773 7fd046962780  0 ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4), process ceph-osd, pid 31785
   -17> 2012-12-05 10:21:43.595944 7fd046962780  1 finished global_init_daemonize
   -16> 2012-12-05 10:21:43.608251 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is supported and appears to work
   -15> 2012-12-05 10:21:43.608262 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
   -14> 2012-12-05 10:21:43.608495 7fd046962780  0 filestore(/ceph/osd.43/) mount did NOT detect btrfs
   -13> 2012-12-05 10:21:43.613072 7fd046962780  0 filestore(/ceph/osd.43/) mount syscall(__NR_syncfs, fd) fully supported
   -12> 2012-12-05 10:21:43.613151 7fd046962780  0 filestore(/ceph/osd.43/) mount found snaps <>
   -11> 2012-12-05 10:21:43.615479 7fd046962780  0 filestore(/ceph/osd.43/) mount: enabling WRITEAHEAD journal mode: btrfs not detected
   -10> 2012-12-05 10:21:43.638102 7fd046962780  0 journal  kernel version is 3.6.7
    -9> 2012-12-05 10:21:43.768129 7fd046962780  0 journal  kernel version is 3.6.7
    -8> 2012-12-05 10:21:43.819826 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is supported and appears to work
    -7> 2012-12-05 10:21:43.819835 7fd046962780  0 filestore(/ceph/osd.43/) mount FIEMAP ioctl is disabled via 'filestore fiemap' config option
    -6> 2012-12-05 10:21:43.820065 7fd046962780  0 filestore(/ceph/osd.43/) mount did NOT detect btrfs
    -5> 2012-12-05 10:21:43.821567 7fd046962780  0 filestore(/ceph/osd.43/) mount syscall(__NR_syncfs, fd) fully supported
    -4> 2012-12-05 10:21:43.821622 7fd046962780  0 filestore(/ceph/osd.43/) mount found snaps <>
    -3> 2012-12-05 10:21:43.822791 7fd046962780  0 filestore(/ceph/osd.43/) mount: enabling WRITEAHEAD journal mode: btrfs not detected
    -2> 2012-12-05 10:21:43.837954 7fd046962780  0 journal  kernel version is 3.6.7
    -1> 2012-12-05 10:21:43.898018 7fd046962780  0 journal  kernel version is 3.6.7
     0> 2012-12-05 10:46:40.709056 7fd03c4b6700 -1 os/JournalingObjectStore.cc: In function 'uint64_t JournalingObjectStore::ApplyManager::op_apply_start(uint64_t)' thread 7fd03c4b6700 time 2012-12-05 10:46:40.338489
os/JournalingObjectStore.cc: 134: FAILED assert(op > committed_seq)

 ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
 1: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned long)+0x816) [0x747626]
 2: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
 3: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
 4: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
 5: (()+0x68ca) [0x7fd04633f8ca]
 6: (clone()+0x6d) [0x7fd0447aeb6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 0 lockdep
   0/ 0 context
   0/ 0 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 0 buffer
   0/ 0 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 0 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 0 osd
   0/ 0 optracker
   0/ 0 objclass
   0/ 0 filestore
   0/ 0 journal
   0/ 0 ms
   1/ 5 mon
   0/ 0 monc
   0/ 5 paxos
   0/ 0 tp
   0/ 0 auth
   1/ 5 crypto
   0/ 0 finisher
   0/ 0 heartbeatmap
   0/ 0 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   0/ 0 asok
   0/ 0 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent    100000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.43.log
--- end dump of recent events ---
2012-12-05 10:46:40.710600 7fd03c4b6700 -1 *** Caught signal (Aborted) **
 in thread 7fd03c4b6700

 ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
 1: /usr/bin/ceph-osd() [0x797bd9]
 2: (()+0xeff0) [0x7fd046347ff0]
 3: (gsignal()+0x35) [0x7fd0447111b5]
 4: (abort()+0x180) [0x7fd044713fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd044fa5dc5]
 6: (()+0xcb166) [0x7fd044fa4166]
 7: (()+0xcb193) [0x7fd044fa4193]
 8: (()+0xcb28e) [0x7fd044fa428e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9) [0x7fb939]
 10: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned long)+0x816) [0x747626]
 11: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
 12: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
 13: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
 14: (()+0x68ca) [0x7fd04633f8ca]
 15: (clone()+0x6d) [0x7fd0447aeb6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- begin dump of recent events ---
     0> 2012-12-05 10:46:40.710600 7fd03c4b6700 -1 *** Caught signal (Aborted) **
 in thread 7fd03c4b6700

 ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
 1: /usr/bin/ceph-osd() [0x797bd9]
 2: (()+0xeff0) [0x7fd046347ff0]
 3: (gsignal()+0x35) [0x7fd0447111b5]
 4: (abort()+0x180) [0x7fd044713fc0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7fd044fa5dc5]
 6: (()+0xcb166) [0x7fd044fa4166]
 7: (()+0xcb193) [0x7fd044fa4193]
 8: (()+0xcb28e) [0x7fd044fa428e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x7c9) [0x7fb939]
 10: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned long)+0x816) [0x747626]
 11: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
 12: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
 13: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
 14: (()+0x68ca) [0x7fd04633f8ca]
 15: (clone()+0x6d) [0x7fd0447aeb6d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 0 lockdep
   0/ 0 context
   0/ 0 crush
   1/ 5 mds
   1/ 5 mds_balancer
   1/ 5 mds_locker
   1/ 5 mds_log
   1/ 5 mds_log_expire
   1/ 5 mds_migrator
   0/ 0 buffer
   0/ 0 timer
   0/ 1 filer
   0/ 1 striper
   0/ 1 objecter
   0/ 5 rados
   0/ 5 rbd
   0/ 0 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 0 osd
   0/ 0 optracker
   0/ 0 objclass
   0/ 0 filestore
   0/ 0 journal
   0/ 0 ms
   1/ 5 mon
   0/ 0 monc
   0/ 5 paxos
   0/ 0 tp
   0/ 0 auth
   1/ 5 crypto
   0/ 0 finisher
   0/ 0 heartbeatmap
   0/ 0 perfcounter
   1/ 5 rgw
   1/ 5 hadoop
   1/ 5 javaclient
   0/ 0 asok
   0/ 0 throttle
  -2/-2 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent    100000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.43.log
--- end dump of recent events ---

--------------010703020706040003050105--
