From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: OSD crashes
Date: Mon, 18 Sep 2017 14:24:05 -0400
Message-ID: <CAGbviv+U-ruu37HwH+jRhw0z1Mn1_ZcCsS0DDC655h-qjfcvQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:44145 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbdIRSYH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 14:24:07 -0400
Received: by mail-it0-f45.google.com with SMTP id r131so6895600itc.1
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 11:24:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

We have a cluster going through a heavy rebalance operation, but its
hampered by several OSDs that keep crashing and restarting.

Jewel 10.2.7
Ubuntu 16.04.2

Here is a dump of one of the crashing OSD logs:



     0> 2017-09-18 14:08:18.631931 7f481207d8c0 -1 *** Caught signal
(Aborted) **
 in thread 7f481207d8c0 thread_name:ceph-osd

 ceph version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185)
 1: (()+0x9770ae) [0x557bbc5fc0ae]
 2: (()+0x11390) [0x7f4810f3b390]
 3: (gsignal()+0x38) [0x7f480eed9428]
 4: (abort()+0x16a) [0x7f480eedb02a]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x16d) [0x7f480f81b84d]
 6: (()+0x8d6b6) [0x7f480f8196b6]
 7: (()+0x8d701) [0x7f480f819701]
 8: (()+0x8d919) [0x7f480f819919]
 9: (()+0x1230f) [0x7f4811c1330f]
 10: (operator new[](unsigned long)+0x4e7) [0x7f4811c374b7]
 11: (leveldb::ReadBlock(leveldb::RandomAccessFile*,
leveldb::ReadOptions const&, leveldb::BlockHandle const&,
leveldb::BlockContents*)+0x313) [0x7f48115c4e63]
 12: (leveldb::Table::BlockReader(void*, leveldb::ReadOptions const&,
leveldb::Slice const&)+0x276) [0x7f48115c9426]
 13: (()+0x421be) [0x7f48115cd1be]
 14: (()+0x42240) [0x7f48115cd240]
 15: (()+0x4261e) [0x7f48115cd61e]
 16: (()+0x3d835) [0x7f48115c8835]
 17: (()+0x1fffb) [0x7f48115aaffb]
 18: (_ZN12LevelDBStore29LevelDBWholeSpaceIteratorImpl4nextEv()+0x8f)
[0x557bbc4b7a3f]
 19: (_ZN11DBObjectMap23DBObjectMapIteratorImpl4nextEb()+0x34) [0x557bbc46bb24]
 20: (PGLog::read_log(ObjectStore*, coll_t, coll_t, ghobject_t,
pg_info_t const&, std::map<eversion_t, hobject_t,
std::less<eversion_t>, std::allocator<std::pair<eversion_t const,
hobject_t> > >&, PGLog::IndexedLog&, pg_missing_t&,
std::__cxx11::basic_ostringstream<char, std::char_traits<char>,
std::allocator<char> >&, DoutPrefixProvider const*,
std::set<std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >, std::less<std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> > >,
std::allocator<std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> > > >*)+0xac3)
[0x557bbc2a9653]
 21: (_ZN2PG10read_stateEP11ObjectStoreRN4ceph6buffer4listE()+0x2f6)
[0x557bbc0db306]
 22: (OSD::load_pgs()+0x87a) [0x557bbc016f0a]
 23: (OSD::init()+0x2026) [0x557bbc0221f6]
 24: (main()+0x2ea5) [0x557bbbf93dc5]
 25: (__libc_start_main()+0xf0) [0x7f480eec4830]
 26: (_start()+0x29) [0x557bbbfd5459]
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
   0/ 5 rbd_mirror
   0/ 5 rbd_replay
   0/ 5 journaler
   0/ 5 objectcacher
   0/ 5 client
   0/ 5 osd
   0/ 5 optracker
   0/ 5 objclass
   1/ 3 filestore
   1/ 3 journal
   0/ 1 ms
   0/ 1 mon
   0/10 monc
   1/ 5 paxos
   0/ 5 tp
   1/ 5 auth
   1/ 5 crypto
   1/ 1 finisher
   1/ 5 heartbeatmap
   1/ 5 perfcounter
   1/ 5 rgw
   1/10 civetweb
   1/ 5 javaclient
   1/ 5 asok
   1/ 1 throttle
   0/ 0 refs
   1/ 5 xio
   1/ 5 compressor
   1/ 5 newstore
   1/ 5 bluestore
   1/ 5 bluefs
   1/ 3 bdev
   1/ 5 kstore
   4/ 5 rocksdb
   0/ 1 leveldb
   1/ 5 kinetic
   1/ 5 fuse
  99/99 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.70.log
--- end dump of recent events ---
