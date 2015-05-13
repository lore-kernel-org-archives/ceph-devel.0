From: David Zafman <dzafman@redhat.com>
Subject: osd/PGLog.cc: 716: FAILED assert(log.log.size() == log_keys_debug.size())
Date: Tue, 12 May 2015 18:01:29 -0700
Message-ID: <5552A269.5050404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34890 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964896AbbEMBBa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 May 2015 21:01:30 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 9C16BB599C
	for <ceph-devel@vger.kernel.org>; Wed, 13 May 2015 01:01:30 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


Your debugging code dumped out information ( tracker #10718 )

ubuntu@teuthology:/a/dzafman-2015-05-12_08:43:26-rados-wip-10809-11135-10290---basic-multi/887648

Missing 562'201 in log_keys_debug?

2015-05-12 14:36:52.874844 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (562'201,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] handle_peering_event: epoch_sent: 718 epoch_requested: 718 
MLogRec from 0
2015-05-12 14:36:52.874868 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (562'201,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] state<Started/Primary/Peering/GetLog>: GetLog: received 
master log from osd0
2015-05-12 14:36:52.874883 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (562'201,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] state<Started/Primary/Peering/GetLog>: leaving GetLog
2015-05-12 14:36:52.874896 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (562'201,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] state<Started/Primary/Peering/GetLog>: processing master log
2015-05-12 14:36:52.874907 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (562'201,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] proc_master_log for osd.0: log((0'0,562'201], crt=562'201) 
missing(0)
2015-05-12 14:36:52.874921 7f40906cf700 10 merge_log log((0'0,562'201], 
crt=562'201) from osd.0 into log((562'201,562'201], crt=562'201)
2015-05-12 14:36:52.874925 7f40906cf700 10 merge_log extending tail to 0'0
2015-05-12 14:36:52.874928 7f40906cf700 15 15'134 (0'0) modify 
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2212 2015-05-12 
14:04:42.823178
2015-05-12 14:36:52.874938 7f40906cf700 15 15'135 (15'134) modify 
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2213 2015-05-12 
14:04:42.844801
2015-05-12 14:36:52.874944 7f40906cf700 15 15'136 (15'135) modify 
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2214 2015-05-12 
14:04:42.848297
2015-05-12 14:36:52.874949 7f40906cf700 15 15'137 (15'136) modify 
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2215 2015-05-12 
14:04:42.848357
2015-05-12 14:36:52.874955 7f40906cf700 15 279'175 (15'137) modify 
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5420 2015-05-12 
14:19:04.447741
2015-05-12 14:36:52.874960 7f40906cf700 15 279'176 (279'175) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5421 2015-05-12 
14:19:04.464582
2015-05-12 14:36:52.874965 7f40906cf700 15 279'177 (279'176) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5422 2015-05-12 
14:19:04.464660
2015-05-12 14:36:52.874971 7f40906cf700 15 337'178 (279'177) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5808 2015-05-12 
14:20:50.892462
2015-05-12 14:36:52.874977 7f40906cf700 15 337'179 (337'178) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5809 2015-05-12 
14:20:50.914984
2015-05-12 14:36:52.874982 7f40906cf700 15 337'180 (337'179) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5810 2015-05-12 
14:20:50.916936
2015-05-12 14:36:52.874987 7f40906cf700 15 337'181 (337'180) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5811 2015-05-12 
14:20:50.916966
2015-05-12 14:36:52.874994 7f40906cf700 15 562'197 (337'181) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7714 2015-05-12 
14:30:30.661467
2015-05-12 14:36:52.874999 7f40906cf700 15 562'198 (562'197) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7715 2015-05-12 
14:30:30.681130
2015-05-12 14:36:52.875004 7f40906cf700 15 562'199 (562'198) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7716 2015-05-12 
14:30:30.700124
2015-05-12 14:36:52.875009 7f40906cf700 15 562'200 (562'199) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7717 2015-05-12 
14:30:30.700243
2015-05-12 14:36:52.875015 7f40906cf700 15 562'201 (562'200) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7718 2015-05-12 
14:30:30.700555
2015-05-12 14:36:52.875020 7f40906cf700 10 merge_log result 
log((0'0,562'201], crt=562'201) missing(0) changed=1
2015-05-12 14:36:52.875025 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering]  peer osd.0 now 1.17( v 562'201 (0'0,562'201] local-les=714 
n=1 ec=6 les/c 714/714 718/718/718) missing(0)
2015-05-12 14:36:52.875046 7f40906cf700  5 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] exit Started/Primary/Peering/GetLog 0.006766 2 0.000301
2015-05-12 14:36:52.875061 7f40906cf700 15 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] publish_stats_to_osd 718:24
2015-05-12 14:36:52.875074 7f40906cf700  5 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] enter Started/Primary/Peering/GetMissing
2015-05-12 14:36:52.875085 7f40906cf700 10 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] state<Started/Primary/Peering/GetMissing>:  still need 
up_thru update before going active
2015-05-12 14:36:52.875098 7f40906cf700  5 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] exit Started/Primary/Peering/GetMissing 0.000024 0 0.000000
2015-05-12 14:36:52.875111 7f40906cf700 15 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] publish_stats_to_osd 718: no change since
2015-05-12 14:36:52.875123 7f40906cf700  5 osd.4 pg_epoch: 718 pg[1.17( 
v 562'201 (0'0,562'201] local-les=714 n=1 ec=6 les/c 714/714 
718/718/718) [4,5] r=0 lpr=718 pi=629-717/4 crt=562'201 lcod 0'0 mlcod 
0'0 peering] enter Started/Primary/Peering/WaitUpThru
2015-05-12 14:36:52.875159 7f40906cf700  5 write_log with: dirty_to: 
562'201, dirty_from: 4294967295'18446744073709551615, 
dirty_divergent_priors: false, divergent_priors: 0, writeout_from: 
4294967295'18446744073709551615, trimmed:
2015-05-12 14:36:52.875277 7f40906cf700 -1 log.log.size() != 
log_keys_debug.size()
2015-05-12 14:36:52.875281 7f40906cf700 -1 actual log:
2015-05-12 14:36:52.875282 7f40906cf700 -1     15'134 (0'0) modify 
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2212 2015-05-12 
14:04:42.823178
2015-05-12 14:36:52.875293 7f40906cf700 -1     15'135 (15'134) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2213 2015-05-12 
14:04:42.844801
2015-05-12 14:36:52.875302 7f40906cf700 -1     15'136 (15'135) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2214 2015-05-12 
14:04:42.848297
2015-05-12 14:36:52.875310 7f40906cf700 -1     15'137 (15'136) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:2215 2015-05-12 
14:04:42.848357
2015-05-12 14:36:52.875319 7f40906cf700 -1     279'175 (15'137) modify   
90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5420 2015-05-12 
14:19:04.447741
2015-05-12 14:36:52.875328 7f40906cf700 -1     279'176 (279'175) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5421 
2015-05-12 14:19:04.464582
2015-05-12 14:36:52.875338 7f40906cf700 -1     279'177 (279'176) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5422 
2015-05-12 14:19:04.464660
2015-05-12 14:36:52.875344 7f40906cf700 -1     337'178 (279'177) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5808 
2015-05-12 14:20:50.892462
2015-05-12 14:36:52.875348 7f40906cf700 -1     337'179 (337'178) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5809 
2015-05-12 14:20:50.914984
2015-05-12 14:36:52.875353 7f40906cf700 -1     337'180 (337'179) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5810 
2015-05-12 14:20:50.916936
2015-05-12 14:36:52.875358 7f40906cf700 -1     337'181 (337'180) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:5811 
2015-05-12 14:20:50.916966
2015-05-12 14:36:52.875363 7f40906cf700 -1     562'197 (337'181) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7714 
2015-05-12 14:30:30.661467
2015-05-12 14:36:52.875368 7f40906cf700 -1     562'198 (562'197) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7715 
2015-05-12 14:30:30.681130
2015-05-12 14:36:52.875373 7f40906cf700 -1     562'199 (562'198) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7716 
2015-05-12 14:30:30.700124
2015-05-12 14:36:52.875377 7f40906cf700 -1     562'200 (562'199) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7717 
2015-05-12 14:30:30.700243
2015-05-12 14:36:52.875382 7f40906cf700 -1     562'201 (562'200) 
modify   90e1ad17/burnupi6122880-441/head//1 by client.4125.0:7718 
2015-05-12 14:30:30.700555
2015-05-12 14:36:52.875387 7f40906cf700 -1 log_keys_debug:
2015-05-12 14:36:52.875388 7f40906cf700 -1 0000000015.00000000000000000134
2015-05-12 14:36:52.875389 7f40906cf700 -1 0000000015.00000000000000000135
2015-05-12 14:36:52.875390 7f40906cf700 -1 0000000015.00000000000000000136
2015-05-12 14:36:52.875391 7f40906cf700 -1 0000000015.00000000000000000137
2015-05-12 14:36:52.875392 7f40906cf700 -1 0000000279.00000000000000000175
2015-05-12 14:36:52.875393 7f40906cf700 -1 0000000279.00000000000000000176
2015-05-12 14:36:52.875393 7f40906cf700 -1 0000000279.00000000000000000177
2015-05-12 14:36:52.875394 7f40906cf700 -1 0000000337.00000000000000000178
2015-05-12 14:36:52.875395 7f40906cf700 -1 0000000337.00000000000000000179
2015-05-12 14:36:52.875396 7f40906cf700 -1 0000000337.00000000000000000180
2015-05-12 14:36:52.875397 7f40906cf700 -1 0000000337.00000000000000000181
2015-05-12 14:36:52.875398 7f40906cf700 -1 0000000562.00000000000000000197
2015-05-12 14:36:52.875398 7f40906cf700 -1 0000000562.00000000000000000198
2015-05-12 14:36:52.875399 7f40906cf700 -1 0000000562.00000000000000000199
2015-05-12 14:36:52.875400 7f40906cf700 -1 0000000562.00000000000000000200
2015-05-12 14:36:52.894933 7f40906cf700 -1 osd/PGLog.cc: In function 
'void PGLog::check()' thread 7f40906cf700 time 2015-05-12 14:36:52.875403
osd/PGLog.cc: 716: FAILED assert(log.log.size() == log_keys_debug.size())

  ceph version 9.0.0-682-g8f4927e (8f4927eab2f016edeb5719f67d109e9abb3180f7)
  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char 
const*)+0x7f) [0xaebcff]
  2: (PGLog::check()+0x794) [0x7324e4]
  3: (PGLog::write_log(ObjectStore::Transaction&, std::map<std::string, 
ceph::buffer::list, std::less<std::string>, 
std::allocator<std::pair<std::string const, ceph::buffer::list> > >*, 
coll_t const&, ghobject_t const&)+0x1c4) [0x73b604]
  4: (PG::write_if_dirty(ObjectStore::Transaction&)+0x87) [0x78e1c7]
  5: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> > 
const&, ThreadPool::TPHandle&)+0x2c0) [0x673c80]
  6: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> > 
const&, ThreadPool::TPHandle&)+0x12) [0x6c9652]
  7: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xadb1de]
  8: (ThreadPool::WorkThread::entry()+0x10) [0xaddfe0]
  9: (()+0x7e9a) [0x7f40a9c14e9a]
  10: (clone()+0x6d) [0x7f40a83bd3fd]
