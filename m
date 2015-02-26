From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 10:26:17 -0500
Message-ID: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:39268 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbBZP0S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 10:26:18 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so9851989oif.2
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 07:26:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Trying to run ceph-mds on a freshly installed firefly cluster with no
ceph FS created yet.

It consistently crashes upon startup. Below is debug output showing
the point of the crash.   Something is obviously misconfigured or
broken but Im at a loss as to where the issue would be. Any ideas?


$ sudo ceph-mds --id mdc03 -d
2015-02-26 05:18:59.107966 7f64fbd81800  0 ceph version 0.80.8
(69eaad7f8308f21573c604f121956e64679a52a7), process ceph-mds, pid 4140
starting mds.mdc03 at :/0
2015-02-26 05:18:59.164721 7f64f6970700  1 mds.-1.0 handle_mds_map standby
2015-02-26 05:19:05.025226 7f64f6970700  1 mds.0.40 handle_mds_map i
am now mds.0.40
2015-02-26 05:19:05.025228 7f64f6970700  1 mds.0.40 handle_mds_map
state change up:standby --> up:replay
2015-02-26 05:19:05.025230 7f64f6970700  1 mds.0.40 replay_start
2015-02-26 05:19:05.025233 7f64f6970700  1 mds.0.40  recovery set is
2015-02-26 05:19:05.025234 7f64f6970700  1 mds.0.40  need osdmap epoch
793, have 792
2015-02-26 05:19:05.025235 7f64f6970700  1 mds.0.40  waiting for
osdmap 793 (which blacklists prior instance)
2015-02-26 05:19:05.026329 7f64f516d700 -1 mds.0.inotable: load_2
could not read table: -2
mds/MDSTable.cc: In function 'void MDSTable::load_2(int,
ceph::bufferlist&, Context*)' thread 7f64f516d700 time 2015-02-26
05:19:05.026341
mds/MDSTable.cc: 152: FAILED assert(r >= 0)
 ceph version 0.80.8 (69eaad7f8308f21573c604f121956e64679a52a7)
 1: (MDSTable::load_2(int, ceph::buffer::list&, Context*)+0x39d) [0x78570d]
 2: (Context::complete(int)+0x9) [0x56d9a9]
 3: (Objecter::check_op_pool_dne(Objecter::Op*)+0x1fd) [0x7ce68d]
 4: (Objecter::C_Op_Map_Latest::finish(int)+0x124) [0x7cea04]
 5: (Context::complete(int)+0x9) [0x56d9a9]
 6: (Finisher::finisher_thread_entry()+0x1b8) [0x9aced8]
 7: (()+0x8182) [0x7f64fb6f0182]
 8: (clone()+0x6d) [0x7f64fa066efd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
2015-02-26 05:19:05.027262 7f64f516d700 -1 mds/MDSTable.cc: In
function 'void MDSTable::load_2(int, ceph::bufferlist&, Context*)'
thread 7f64f516d700 time 2015-02-26 05:19:05.026341
mds/MDSTable.cc: 152: FAILED assert(r >= 0)


More from the output:
...
   -21> 2015-02-26 05:19:05.025486 7f64f6970700  5 mds.0.log open
discovering log bounds
   -20> 2015-02-26 05:19:05.025490 7f64f6970700  1 mds.0.journaler(ro)
recover start
   -19> 2015-02-26 05:19:05.025491 7f64f6970700  1 mds.0.journaler(ro) read_head
   -18> 2015-02-26 05:19:05.025498 7f64f6970700 10 monclient:
get_version osdmap req 0x1f1a060
   -17> 2015-02-26 05:19:05.025499 7f64f6970700 10 monclient:
_send_mon_message to mon.mon03 at 10.2.3.23:6789/0
   -16> 2015-02-26 05:19:05.025501 7f64f6970700  1 --
10.2.3.33:6800/4140 --> 10.2.3.23:6789/0 --
mon_get_version(what=osdmap handle=5) v1 -- ?+0 0x1e80820 con
0x1e1d080
   -15> 2015-02-26 05:19:05.025510 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 17 ====
mon_subscribe_ack(300s) v1 ==== 20+0+0 (2976202784 0 0) 0x1e51340 con
0x1e1d080
   -14> 2015-02-26 05:19:05.025514 7f64f6970700 10 monclient:
handle_subscribe_ack sent 2015-02-26 05:19:05.025239 renew after
2015-02-26 05:21:35.025239
   -13> 2015-02-26 05:19:05.025627 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 18 ====
mon_subscribe_ack(300s) v1 ==== 20+0+0 (2976202784 0 0) 0x1e51180 con
0x1e1d080
   -12> 2015-02-26 05:19:05.025633 7f64f6970700 10 monclient:
handle_subscribe_ack sent 0.000000, ignoring
   -11> 2015-02-26 05:19:05.026301 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 19 ====
mon_check_map_ack(handle=1 version=793) v2 ==== 24+0+0 (1092320547 0
0) 0x1e50e00 con 0x1e1d080
   -10> 2015-02-26 05:19:05.026309 7f64f6970700 10 monclient:
handle_get_version_reply finishing 0x1e8a440 version 793
    -9> 2015-02-26 05:19:05.026315 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 20 ====
mon_check_map_ack(handle=2 version=793) v2 ==== 24+0+0 (2317831232 0
0) 0x1e51500 con 0x1e1d080
    -8> 2015-02-26 05:19:05.026320 7f64f6970700 10 monclient:
handle_get_version_reply finishing 0x1e8a7a0 version 793
    -7> 2015-02-26 05:19:05.026329 7f64f516d700 -1 mds.0.inotable:
load_2 could not read table: -2
    -6> 2015-02-26 05:19:05.027168 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 21 ====
mon_check_map_ack(handle=3 version=793) v2 ==== 24+0+0 (812158670 0 0)
0x1e501c0 con 0x1e1d080
    -5> 2015-02-26 05:19:05.027176 7f64f6970700 10 monclient:
handle_get_version_reply finishing 0x1f1a180 version 793
    -4> 2015-02-26 05:19:05.027180 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 22 ====
mon_check_map_ack(handle=4 version=793) v2 ==== 24+0+0 (431183991 0 0)
0x1e50380 con 0x1e1d080
    -3> 2015-02-26 05:19:05.027185 7f64f6970700 10 monclient:
handle_get_version_reply finishing 0x1f1a100 version 793
    -2> 2015-02-26 05:19:05.027187 7f64f6970700  1 --
10.2.3.33:6800/4140 <== mon.2 10.2.3.23:6789/0 23 ====
mon_check_map_ack(handle=5 version=793) v2 ==== 24+0+0 (2751240953 0
0) 0x1e50a80 con 0x1e1d080
    -1> 2015-02-26 05:19:05.027191 7f64f6970700 10 monclient:
handle_get_version_reply finishing 0x1f1a060 version 793
     0> 2015-02-26 05:19:05.027262 7f64f516d700 -1 mds/MDSTable.cc: In
function 'void MDSTable::load_2(int, ceph::bufferlist&, Context*)'
thread 7f64f516d700 time 2015-02-26 05:19:05.026341
mds/MDSTable.cc: 152: FAILED assert(r >= 0)
