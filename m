From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph-osd fails to start - crash log
Date: Fri, 1 Sep 2017 12:32:31 -0400
Message-ID: <CAGbvivJ-67OZ4W68G+OPrr19+6DZciWMb+6qG2nKERdedUnAZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:34619 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdIAQcd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Sep 2017 12:32:33 -0400
Received: by mail-io0-f170.google.com with SMTP id i200so4624236ioa.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 Sep 2017 09:32:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

ceph 10.2.7
Ubuntu 16.04.2
Kernel: 4.9.44

I have a system in a bad state, and many of the OSDs are failing to
start, they come up for a little while, then die.  I need some help
figuring out how to get these OSDs to come up and stay up so my system
can rebalance itself.

The logs show the following.


   -14> 2017-09-01 12:27:32.836207 7f7ebe62c8c0  5 osd.39 pg_epoch:
47945 pg[26.2a3( empty local-les=46494 n=0 ec=35203 les/c/f
47869/47869/0 47889/47896/47896) [39,30,94] r=0 lpr=0
pi=46430-47895/15 crt=0'0 mlcod 0'0 inactive NIBBLEWISE] enter Reset
   -13> 2017-09-01 12:27:32.878713 7f7ebe62c8c0  5 osd.39 pg_epoch:
47899 pg[7.5f7(unlocked)] enter Initial
   -12> 2017-09-01 12:27:32.910644 7f7ebe62c8c0  5 osd.39 pg_epoch:
47899 pg[7.5f7( v 29917'81518 (18780'78457,29917'81518]
local-les=42702 n=11 ec=1511 les/c/f 42702/41354/0 47896/47896/45989)
[12,39,82]/[12,39] r=1 lpr=0 pi=41345-47895/44 crt=29917'81518 lcod
0'0 inactive NOTIFY NIBBLEWISE] exit Initial 0.031932 0 0.000000
   -11> 2017-09-01 12:27:32.910684 7f7ebe62c8c0  5 osd.39 pg_epoch:
47899 pg[7.5f7( v 29917'81518 (18780'78457,29917'81518]
local-les=42702 n=11 ec=1511 les/c/f 42702/41354/0 47896/47896/45989)
[12,39,82]/[12,39] r=1 lpr=0 pi=41345-47895/44 crt=29917'81518 lcod
0'0 inactive NOTIFY NIBBLEWISE] enter Reset
   -10> 2017-09-01 12:27:32.934425 7f7ebe62c8c0  5 osd.39 pg_epoch:
47899 pg[22.637(unlocked)] enter Initial
    -9> 2017-09-01 12:27:32.934646 7f7ebe62c8c0  5 osd.39 pg_epoch:
47899 pg[22.637( empty local-les=46401 n=0 ec=19250 les/c/f
47869/47869/0 47889/47896/47896) [39,69,35] r=0 lpr=0
pi=46353-47895/12 crt=0'0 mlcod 0'0 inactive NIBBLEWISE] exit Initial
0.000220 0 0.000000
    -8> 2017-09-01 12:27:32.934668 7f7ebe62c8c0  5 osd.39 pg_epoch:
47899 pg[22.637( empty local-les=46401 n=0 ec=19250 les/c/f
47869/47869/0 47889/47896/47896) [39,69,35] r=0 lpr=0
pi=46353-47895/12 crt=0'0 mlcod 0'0 inactive NIBBLEWISE] enter Reset
    -7> 2017-09-01 12:27:32.976842 7f7ebe62c8c0  5 osd.39 pg_epoch:
47922 pg[7.67f(unlocked)] enter Initial
    -6> 2017-09-01 12:27:33.004614 7f7ebe62c8c0  5 osd.39 pg_epoch:
47922 pg[7.67f( v 30030'90009 (19559'86971,30030'90009]
local-les=47002 n=12 ec=1511 les/c/f 47869/47141/0 47889/47893/47893)
[39,13,41] r=0 lpr=0 pi=47001-47892/5 crt=30030'90009 lcod 0'0 mlcod
0'0 inactive NIBBLEWISE] exit Initial 0.027772 0 0.000000
    -5> 2017-09-01 12:27:33.004650 7f7ebe62c8c0  5 osd.39 pg_epoch:
47922 pg[7.67f( v 30030'90009 (19559'86971,30030'90009]
local-les=47002 n=12 ec=1511 les/c/f 47869/47141/0 47889/47893/47893)
[39,13,41] r=0 lpr=0 pi=47001-47892/5 crt=30030'90009 lcod 0'0 mlcod
0'0 inactive NIBBLEWISE] enter Reset
    -4> 2017-09-01 12:27:33.055420 7f7ebe62c8c0  5 osd.39 pg_epoch:
47954 pg[7.62d(unlocked)] enter Initial
    -3> 2017-09-01 12:27:33.128309 7f7ebe62c8c0  5 osd.39 pg_epoch:
47954 pg[7.62d( v 35215'96652 (18780'93637,35215'96652]
local-les=47898 n=17 ec=1511 les/c/f 47898/42466/0 47889/47889/47889)
[39,13,18]/[39,13] r=0 lpr=0 pi=42464-47888/34 crt=35215'96652 lcod
0'0 mlcod 0'0 inactive NIBBLEWISE] exit Initial 0.072890 0 0.000000
    -2> 2017-09-01 12:27:33.128343 7f7ebe62c8c0  5 osd.39 pg_epoch:
47954 pg[7.62d( v 35215'96652 (18780'93637,35215'96652]
local-les=47898 n=17 ec=1511 les/c/f 47898/42466/0 47889/47889/47889)
[39,13,18]/[39,13] r=0 lpr=0 pi=42464-47888/34 crt=35215'96652 lcod
0'0 mlcod 0'0 inactive NIBBLEWISE] enter Reset
    -1> 2017-09-01 12:27:33.144109 7f7ebe62c8c0  5 osd.39 pg_epoch:
47889 pg[7.65c(unlocked)] enter Initial
     0> 2017-09-01 12:27:33.151134 7f7ebe62c8c0 -1 *** Caught signal
(Aborted) **
 in thread 7f7ebe62c8c0 thread_name:ceph-osd

 ceph version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185)
 1: (()+0x9770ae) [0x511ab2e0ae]
 2: (()+0x11390) [0x7f7ebd4ea390]
 3: (gsignal()+0x38) [0x7f7ebb488428]
 4: (abort()+0x16a) [0x7f7ebb48a02a]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x16d) [0x7f7ebbdca84d]
 6: (()+0x8d6b6) [0x7f7ebbdc86b6]
 7: (()+0x8d701) [0x7f7ebbdc8701]
 8: (()+0x8d919) [0x7f7ebbdc8919]
 9: (()+0x1230f) [0x7f7ebe1c230f]
 10: (operator new[](unsigned long)+0x4e7) [0x7f7ebe1e64b7]
 11: (void std::__cxx11::list<pg_log_entry_t,
std::allocator<pg_log_entry_t> >::_M_insert<pg_log_entry_t
const&>(std::_List_iterator<pg_log_entry_t>, pg_log_entry_t
const&)+0x21) [0x511a6f7e21]
 12: (PGLog::read_log(ObjectStore*, coll_t, coll_t, ghobject_t,
pg_info_t const&, std::map<eversion_t, hobject_t,
std::less<eversion_t>, std::allocator<std::pair<eversion_t const,
hobject_t> > >&, PGLog::IndexedLog&, pg_missing_t&,
std::__cxx11::basic_ostringstream<char, std::char_traits<char>,
std::allocator<char> >&, DoutPrefixProvider const*,
std::set<std::__cxx11::basic_string<char, std::char_traits<char>,
std::allocator<char> >, std::less<std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> > >,
std::allocator<std::__cxx11::basic_string<char,
std::char_traits<char>, std::allocator<char> > > >*)+0xe0c)
[0x511a7db99c]
 13: (PG::read_state(ObjectStore*, ceph::buffer::list&)+0x2f6) [0x511a60d306]
 14: (OSD::load_pgs()+0x87a) [0x511a548f0a]
 15: (OSD::init()+0x2026) [0x511a5541f6]
 16: (main()+0x2ea5) [0x511a4c5dc5]
 17: (__libc_start_main()+0xf0) [0x7f7ebb473830]
 18: (_start()+0x29) [0x511a507459]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- logging levels ---
   0/ 5 none
   0/ 1 lockdep
   0/ 1 context
   1/ 1 crush
   0/ 1 mds
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
   4/ 5 leveldb
   1/ 5 kinetic
   1/ 5 fuse
  99/99 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.39.log
--- end dump of recent events ---
