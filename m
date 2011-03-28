From: Jim Schutt <jaschut@sandia.gov>
Subject: Custom CRUSH map isn't working with master branch?
Date: Mon, 28 Mar 2011 14:53:19 -0600
Message-ID: <4D90F53F.1030101@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:53752 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1C1VLR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 17:11:17 -0400
Received: from mailgate.sandia.gov (mailgate.sandia.gov [132.175.109.1])
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1697256B4E0
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 14:53:23 -0600 (MDT)
Received: from mail.sandia.gov (exch01.sandia.gov [134.253.103.1] (may be forged))
	by mailgate.sandia.gov (8.14.4/8.14.4) with ESMTP id p2SKrB3B020733
	for <ceph-devel@vger.kernel.org>; Mon, 28 Mar 2011 14:53:11 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I'm trying to build a new filesystem using master branch
(commit 9f5736039dc8).  I'm following the directions at
the top of mkcephfs for using parallel job launching.

If I don't specify a CRUSH map, everything works
as expected.

If I prepare a custom CRUSH map, and specify it in
my ceph.conf via

[mon]
	crush map = /etc/ceph/crushmap

then my mds segfaults almost immediately after starting.

During the "mkcephfs --prepare-mon" phase, my CRUSH map
seems to be acceptable:

Building osdmap
  highest numbered osd in /bigdata2/ceph/setup/tmp.mkcephfs/conf is osd.95
  num osd = 96
/usr/bin/osdmaptool: osdmap file '/bigdata2/ceph/setup/tmp.mkcephfs/osdmap'
2011-03-28 14:35:30.637788 7f62f25e26f0 10 failure domains, 10 osds each
/usr/bin/osdmaptool: writing epoch 1 to /bigdata2/ceph/setup/tmp.mkcephfs/osdmap
Importing crush map from /etc/ceph/crushmap
/usr/bin/osdmaptool: osdmap file '/bigdata2/ceph/setup/tmp.mkcephfs/osdmap'
/usr/bin/osdmaptool: imported 3391 byte crush map from /etc/ceph/crushmap
/usr/bin/osdmaptool: writing epoch 2 to /bigdata2/ceph/setup/tmp.mkcephfs/osdmap

I am a little curious about that "10 failure domains, 10 osds each",
as my custom CRUSH map as 12 failure domains, 8 osds each.

Here's the complete contents of my mds log, at debug mds = 20:


ceph version 0.25-453-g9f57360.commit: 9f5736039dc883b2c8605f9a55418f8c6dfb2aa6. process: cmds. pid: 20084
2011-03-28 14:40:23.234825 7fdb815aa710 -- 0.0.0.0:6800/20084 accepter.bind ms_addr is 0.0.0.0:6800/20084 need_addr=1
2011-03-28 14:40:23.235223 7fdb815aa710 -- 0.0.0.0:6800/20084 messenger.start
2011-03-28 14:40:23.235821 7fdb815aa710 -- 0.0.0.0:6800/20084 messenger.start daemonized
2011-03-28 14:40:23.235848 7fdb815aa710 -- 0.0.0.0:6800/20084 accepter.start
2011-03-28 14:40:23.236485 7fdb815aa710 mds-1.0 168     MDSCacheObject
2011-03-28 14:40:23.236500 7fdb815aa710 mds-1.0 2192    CInode
2011-03-28 14:40:23.236509 7fdb815aa710 mds-1.0 16       elist<>::item   *7=112
2011-03-28 14:40:23.236517 7fdb815aa710 mds-1.0 360      inode_t
2011-03-28 14:40:23.236525 7fdb815aa710 mds-1.0 56        nest_info_t
2011-03-28 14:40:23.236533 7fdb815aa710 mds-1.0 32        frag_info_t
2011-03-28 14:40:23.236541 7fdb815aa710 mds-1.0 40       SimpleLock   *5=200
2011-03-28 14:40:23.236550 7fdb815aa710 mds-1.0 48       ScatterLock  *3=144
2011-03-28 14:40:23.236558 7fdb815aa710 mds-1.0 472     CDentry
2011-03-28 14:40:23.236587 7fdb815aa710 mds-1.0 16       elist<>::item
2011-03-28 14:40:23.236601 7fdb815aa710 mds-1.0 40       SimpleLock
2011-03-28 14:40:23.236610 7fdb815aa710 mds-1.0 1560    CDir
2011-03-28 14:40:23.236618 7fdb815aa710 mds-1.0 16       elist<>::item   *2=32
2011-03-28 14:40:23.236626 7fdb815aa710 mds-1.0 192      fnode_t
2011-03-28 14:40:23.236634 7fdb815aa710 mds-1.0 56        nest_info_t *2
2011-03-28 14:40:23.236642 7fdb815aa710 mds-1.0 32        frag_info_t *2
2011-03-28 14:40:23.236650 7fdb815aa710 mds-1.0 168     Capability
2011-03-28 14:40:23.236658 7fdb815aa710 mds-1.0 32       xlist<>::item   *2=64
2011-03-28 14:40:23.236955 7fdb815aa710 -- 0.0.0.0:6800/20084 --> mon0 172.17.40.34:6789/0 -- auth(proto 0 29 bytes) v1 -- ?+0 0x10cde00
2011-03-28 14:40:23.237761 7fdb815a9940 -- 172.17.40.35:6800/20084 learned my addr 172.17.40.35:6800/20084
2011-03-28 14:40:23.237807 7fdb815a9940 mds-1.0 MDS::ms_get_authorizer type=mon
2011-03-28 14:40:23.238068 7fdb7dfea940 mds-1.0 ms_handle_connect on 172.17.40.34:6789/0
2011-03-28 14:40:23.238884 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 1 ==== auth_reply(proto 1 0 Success) v1 ==== 24+0+0 (751118662 0 0) 0x10ef000 con 0x10e63c0
2011-03-28 14:40:23.238939 7fdb7dfea940 -- 172.17.40.35:6800/20084 --> mon0 172.17.40.34:6789/0 -- mon_subscribe({monmap=0+}) v1 -- ?+0 0x10ee380
2011-03-28 14:40:23.239018 7fdb815aa710 mds-1.0 beacon_send up:boot seq 1 (currently up:boot)
2011-03-28 14:40:23.239057 7fdb815aa710 -- 172.17.40.35:6800/20084 --> mon0 172.17.40.34:6789/0 -- mdsbeacon(4097/an15 up:boot seq 1 v0) v1 -- ?+0 0x10d8a00
2011-03-28 14:40:23.239105 7fdb815aa710 -- 172.17.40.35:6800/20084 --> mon0 172.17.40.34:6789/0 -- mon_subscribe({monmap=0+,osdmap=0}) v1 -- ?+0 0x10ee1c0
2011-03-28 14:40:23.239159 7fdb815aa710 -- 172.17.40.35:6800/20084 --> mon0 172.17.40.34:6789/0 -- mon_subscribe({mdsmap=0+,monmap=0+,osdmap=0}) v1 -- ?+0 0x10ee8c0
2011-03-28 14:40:23.239243 7fdb815aa710 mds-1.0 open_logger
2011-03-28 14:40:23.314234 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 2 ==== mon_map v1 ==== 190+0+0 (138844621 0 0) 0x10ee380 con 0x10e63c0
2011-03-28 14:40:23.314406 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 3 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (2838993680 0 0) 0x10c7900 con 0x10e63c0
2011-03-28 14:40:23.314470 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 4 ==== mon_map v1 ==== 190+0+0 (138844621 0 0) 0x10eea80 con 0x10e63c0
2011-03-28 14:40:23.314736 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 5 ==== osd_map(1,1) v1 ==== 3519+0+0 (3336496870 0 0) 0x10ef400 con 0x10e63c0
2011-03-28 14:40:23.315416 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 6 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (2838993680 0 0) 0x10c7c00 con 0x10e63c0
2011-03-28 14:40:23.315490 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 7 ==== mdsmap(e 1) v1 ==== 301+0+0 (1302424407 0 0) 0x10ef200 con 0x10e63c0
2011-03-28 14:40:23.315508 7fdb7dfea940 mds-1.0 handle_mds_map epoch 1 from mon0
2011-03-28 14:40:23.315584 7fdb7dfea940 mds-1.0      my compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2011-03-28 14:40:23.315597 7fdb7dfea940 mds-1.0  mdsmap compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2011-03-28 14:40:23.315616 7fdb7dfea940 mds-1.0 map says i am 172.17.40.35:6800/20084 mds-1 state down:dne
2011-03-28 14:40:23.315626 7fdb7dfea940 mds-1.0 not in map yet
2011-03-28 14:40:23.315723 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 8 ==== mon_map v1 ==== 190+0+0 (138844621 0 0) 0x10ee1c0 con 0x10e63c0
2011-03-28 14:40:23.315755 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 9 ==== osd_map(1,1) v1 ==== 3519+0+0 (3336496870 0 0) 0x10ef600 con 0x10e63c0
2011-03-28 14:40:23.315835 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 10 ==== mon_subscribe_ack(300s) v1 ==== 20+0+0 (2838993680 0 0) 0x10c7a80 con 0x10e63c0
2011-03-28 14:40:27.239167 7fdb7cee7940 mds-1.0 beacon_send up:boot seq 2 (currently down:dne)
2011-03-28 14:40:27.239276 7fdb7cee7940 -- 172.17.40.35:6800/20084 --> mon0 172.17.40.34:6789/0 -- mdsbeacon(4097/an15 up:boot seq 2 v1) v1 -- ?+0 0x10f1a00
2011-03-28 14:40:27.312369 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 11 ==== mdsmap(e 2) v1 ==== 502+0+0 (2502043643 0 0) 0x10ef000 con 0x10e63c0
2011-03-28 14:40:27.312409 7fdb7dfea940 mds-1.0 handle_mds_map epoch 2 from mon0
2011-03-28 14:40:27.312476 7fdb7dfea940 mds-1.0      my compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2011-03-28 14:40:27.312489 7fdb7dfea940 mds-1.0  mdsmap compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2011-03-28 14:40:27.312504 7fdb7dfea940 mds-1.0 map says i am 172.17.40.35:6800/20084 mds-1 state up:standby
2011-03-28 14:40:27.312513 7fdb7dfea940 mds-1.0 handle_mds_map standby
2011-03-28 14:40:27.385339 7fdb7dfea940 -- 172.17.40.35:6800/20084 <== mon0 172.17.40.34:6789/0 12 ==== mdsmap(e 3) v1 ==== 526+0+0 (3892115851 0 0) 0x10efa00 con 0x10e63c0
2011-03-28 14:40:27.385379 7fdb7dfea940 mds-1.0 handle_mds_map epoch 3 from mon0
2011-03-28 14:40:27.385471 7fdb7dfea940 mds-1.0      my compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2011-03-28 14:40:27.385484 7fdb7dfea940 mds-1.0  mdsmap compat compat={},rocompat={},incompat={1=base v0.20,2=client writeable ranges,3=default file layouts on dirs,4=dir inode in separate object}
2011-03-28 14:40:27.385499 7fdb7dfea940 mds0.0 map says i am 172.17.40.35:6800/20084 mds0 state up:creating
2011-03-28 14:40:27.385585 7fdb7dfea940 mds0.1 handle_mds_map i am now mds0.1
2011-03-28 14:40:27.385600 7fdb7dfea940 mds0.1 handle_mds_map state change up:standby --> up:creating
2011-03-28 14:40:27.385610 7fdb7dfea940 mds0.1 boot_create
2011-03-28 14:40:27.385634 7fdb7dfea940 mds0.1 boot_create creating fresh journal
2011-03-28 14:40:27.385655 7fdb7dfea940 mds0.log create empty log
*** Caught signal (Segmentation fault) **
  in thread 0x7fdb7dfea940
  ceph version 0.25-453-g9f57360 (commit:9f5736039dc883b2c8605f9a55418f8c6dfb2aa6)
  1: (ceph::BackTrace::BackTrace(int)+0x2a) [0x9e34fe]
  2: /usr/bin/cmds [0x9fcad0]
  3: /lib64/libpthread.so.0 [0x7fdb80c3ab10]
  4: (OSDMap::object_locator_to_pg(object_t const&, object_locator_t const&)+0x9c) [0x97f764]
  5: (Objecter::recalc_op_target(Objecter::Op*)+0xa3) [0x957127]
  6: (Objecter::op_submit(Objecter::Op*, Objecter::OSDSession*)+0xf2) [0x958402]
  7: (Objecter::write_full(object_t const&, object_locator_t const&, SnapContext const&, ceph::buffer::list const&, utime_t, int, Context*, Context*, eversion_t*, ObjectOperation*)+0x183) [0x92296f]
  8: (Journaler::write_head(Context*)+0x2ee) [0x98fc1e]
  9: (MDLog::write_head(Context*)+0x21) [0x94d8dd]
  10: (MDLog::create(Context*)+0xf1) [0x94f77d]
  11: (MDS::boot_create()+0x218) [0x739050]
  12: (MDS::handle_mds_map(MMDSMap*)+0x194f) [0x74043f]
  13: (MDS::handle_core_message(Message*)+0x3e0) [0x7415b6]
  14: (MDS::_dispatch(Message*)+0x637) [0x7422fb]
  15: (MDS::ms_dispatch(Message*)+0x2f) [0x743973]
  16: (Messenger::ms_deliver_dispatch(Message*)+0x55) [0x7216c3]
  17: (SimpleMessenger::dispatch_entry()+0x651) [0x7089fd]
  18: (SimpleMessenger::DispatchThread::entry()+0x29) [0x705563]
  19: (Thread::_entry_func(void*)+0x20) [0x718fa4]
  20: /lib64/libpthread.so.0 [0x7fdb80c3273d]
  21: (clone()+0x6d) [0x7fdb7ffa8f6d]


gdb had this to say:

(gdb) bt
#0  0x00007fdb80c3a9dd in raise (sig=<value optimized out>) at ../nptl/sysdeps/unix/sysv/linux/pt-raise.c:41
#1  0x00000000009fc990 in reraise_fatal (signum=11) at common/signal.cc:63
#2  0x00000000009fcb43 in handle_fatal_signal (signum=11) at common/signal.cc:110
#3  <signal handler called>
#4  0x000000000097f764 in OSDMap::object_locator_to_pg (this=0x10ea000, oid=..., loc=...) at ./osd/OSDMap.h:748
#5  0x0000000000957127 in Objecter::recalc_op_target (this=0x1077b40, op=0x10f9120) at osdc/Objecter.cc:561
#6  0x0000000000958402 in Objecter::op_submit (this=0x1077b40, op=0x10f9120, s=0x0) at osdc/Objecter.cc:490
#7  0x000000000092296f in Objecter::write_full (this=0x1077b40, oid=..., oloc=..., snapc=..., bl=..., mtime=..., flags=0, onack=0x0, oncommit=0x107d060, objver=0x0, extra_ops=0x0) at ./osdc/Objecter.h:844
#8  0x000000000098fc1e in Journaler::write_head (this=0x10ea300, oncommit=0x10b1840) at osdc/Journaler.cc:333
#9  0x000000000094d8dd in MDLog::write_head (this=0x10c7300, c=0x10b1840) at mds/MDLog.cc:99
#10 0x000000000094f77d in MDLog::create (this=0x10c7300, c=0x10b1840) at mds/MDLog.cc:124
#11 0x0000000000739050 in MDS::boot_create (this=0x10e9a00) at mds/MDS.cc:1090
#12 0x000000000074043f in MDS::handle_mds_map (this=0x10e9a00, m=0x10efa00) at mds/MDS.cc:949
#13 0x00000000007415b6 in MDS::handle_core_message (this=0x10e9a00, m=0x10efa00) at mds/MDS.cc:1663
#14 0x00000000007422fb in MDS::_dispatch (this=0x10e9a00, m=0x10efa00) at mds/MDS.cc:1794
#15 0x0000000000743973 in MDS::ms_dispatch (this=0x10e9a00, m=0x10efa00) at mds/MDS.cc:1615
#16 0x00000000007216c3 in Messenger::ms_deliver_dispatch (this=0x10c9500, m=0x10efa00) at msg/Messenger.h:98
#17 0x00000000007089fd in SimpleMessenger::dispatch_entry (this=0x10c9500) at msg/SimpleMessenger.cc:352
#18 0x0000000000705563 in SimpleMessenger::DispatchThread::entry (this=0x10c9988) at ./msg/SimpleMessenger.h:533
#19 0x0000000000718fa4 in Thread::_entry_func (arg=0x10c9988) at ./common/Thread.h:41
#20 0x00007fdb80c3273d in start_thread (arg=<value optimized out>) at pthread_create.c:301
#21 0x00007fdb7ffa8f6d in clone () from /lib64/libc.so.6
(gdb) f 4
#4  0x000000000097f764 in OSDMap::object_locator_to_pg (this=0x10ea000, oid=..., loc=...) at ./osd/OSDMap.h:748
748           ps = ceph_str_hash(pool->v.object_hash, oid.name.c_str(), oid.name.length());
(gdb) p pool
$1 = (const pg_pool_t *) 0x0
(gdb) p loc
$2 = (const object_locator_t &) @0x10f9158: {pool = 1, preferred = -1, key = {static npos = 18446744073709551615, _M_dataplus = {<std::allocator<char>> = {<__gnu_cxx::new_allocator<char>> = {<No data fields>}, <No data fields>}, _M_p = 0x7fdb809ace18 ""}}}
(gdb) p oid
$3 = (const object_t &) @0x10f9150: {name = {static npos = 18446744073709551615, _M_dataplus = {<std::allocator<char>> = {<__gnu_cxx::new_allocator<char>> = {<No data fields>}, <No data fields>}, _M_p = 0x10f0558 "200.00000000"}}}
(gdb) p pools
$4 = {_M_t = {_M_impl = {<std::allocator<std::_Rb_tree_node<std::pair<int const, pg_pool_t> > >> = {<__gnu_cxx::new_allocator<std::_Rb_tree_node<std::pair<int const, pg_pool_t> > >> = {<No data fields>}, <No data fields>},
       _M_key_compare = {<std::binary_function<int, int, bool>> = {<No data fields>}, <No data fields>}, _M_header = {_M_color = _S_red, _M_parent = 0x0, _M_left = 0x10ea100, _M_right = 0x10ea100}, _M_node_count = 0}}}


So it looks like it's trying to look up an object, but there are no pools?
Any idea what could cause this?

Thanks -- Jim
