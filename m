From: "Smets, Jan (Jan)" <jan.smets@alcatel-lucent.com>
Subject: Replication ?
Date: Wed, 20 Oct 2010 17:52:56 +0200
Message-ID: <14C7F4F06DB5814AB0DE29716C4F6D670EB3634F@FRMRSSXCHMBSB1.dc-m.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smail3.alcatel.fr ([62.23.212.56]:41550 "EHLO smail3.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab0JTQBX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Oct 2010 12:01:23 -0400
Received: from FRMRSSXCHHUB02.dc-m.alcatel-lucent.com (FRMRSSXCHHUB02.dc-m.alcatel-lucent.com [135.120.45.62])
	by smail3.alcatel.fr (8.14.3/8.14.3/ICT) with ESMTP id o9KFqnjS011788
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 20 Oct 2010 17:52:49 +0200
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi !

I got this while running dd on my client.  

Version: 0.22-4
Kernel 2.6.36-rc6-amd64 

I'm not sure what happend, but I get reconnects all the time.



MDS LOG
2010-10-20 17:26:58.412976 7fe9958c3710 mds0.cache.ino(10000000000) pop_projected_snaprealm 0xe32240 seq1
2010-10-20 17:27:02.125598 7fe9958c3710 mds0.1 ms_handle_connect on 138.203.10.98:6801/4082
2010-10-20 17:27:02.126914 7fe9958c3710 mds0.1 ms_handle_connect on 138.203.10.98:6803/4145
2010-10-20 17:27:02.127297 7fe9958c3710 mds0.1 ms_handle_connect on 138.203.10.100:6801/1872
2010-10-20 17:31:45.054538 7fe9958c3710 mds0.1 ms_handle_reset on 138.203.10.99:6801/1928
2010-10-20 17:31:49.747621 7fe992ab8710 -- 138.203.10.99:6800/1878 >> 138.203.10.99:6801/1928 pipe(0x11e6a00 sd=-1 pgs=0 cs=0 l=0).fault first fault



OSD LOG
2010-10-20 17:27:02.163062 7f6190802710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x1ca5c80 sd=17 pgs=0 cs=0 l=0).accept connect_seq 0 vs existing 0 state 1
2010-10-20 17:27:02.164726 7f6191d17710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x2765c80 sd=-1 pgs=22 cs=1 l=0).fault initiating reconnect
2010-10-20 17:27:02.182279 7f6191d17710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x2765c80 sd=17 pgs=22 cs=2 l=0).connect got RESETSESSION
2010-10-20 17:27:02.185784 7f6190802710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x2765c80 sd=-1 pgs=24 cs=1 l=0).fault with nothing to send, going to standby
2010-10-20 17:31:43.490051 7f6190701710 -- 138.203.10.99:6801/1928 >> 138.203.10.101:0/2078945276 pipe(0x25de780 sd=17 pgs=0 cs=0 l=0).accept peer addr is really 138.203.10.101:0/2078945276 (socket is 138.203.10.101:36116/0)
2010-10-20 17:31:43.537038 7f6190701710 -- 138.203.10.99:6801/1928 >> 138.203.10.101:0/2078945276 pipe(0x25de780 sd=17 pgs=14 cs=1 l=1).reader got 128 + 0 + 4194304 byte message.. ABORTED
2010-10-20 17:31:43.537131 7f6190701710 -- 138.203.10.99:6801/1928 >> 138.203.10.101:0/2078945276 pipe(0x25de780 sd=17 pgs=14 cs=1 l=1).reader bad tag 0
2010-10-20 17:31:43.549951 7f6190701710 -- 138.203.10.99:6801/1928 >> 138.203.10.101:0/2078945276 pipe(0x25de500 sd=17 pgs=0 cs=0 l=0).accept peer addr is really 138.203.10.101:0/2078945276 (socket is 138.203.10.101:36117/0)
2010-10-20 17:31:43.888262 7f61904ff710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x25de000 sd=20 pgs=0 cs=0 l=0).accept connect_seq 0 vs existing 1 state 3
2010-10-20 17:31:43.888386 7f61904ff710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x25de000 sd=20 pgs=0 cs=0 l=0).accept peer reset, then tried to connect to us, replacing
2010-10-20 17:31:43.921381 7f61904ff710 -- 138.203.10.99:6801/1928 >> 138.203.10.98:6801/4082 pipe(0x1ca5c80 sd=20 pgs=0 cs=0 l=0).accept we reset (peer sent cseq 2), sending RESETSESSION
2010-10-20 17:31:44.435729 7f6195b24710 osd2 7 pg[0.f2( v 7'3 (0'0,7'3] n=1 ec=2 les=4 3/3/3) [2,0] r=0 mlcod 4'1 active+clean]  removing repgather(0x2b2f5a0 applied 7'3 rep_tid=146 wfack= wfdisk= op=osd_op(client4107.1:458 10000000002.00000039 [write 0~4194304 [1@-1]] 0.7bf2 snapc 1=[]))
2010-10-20 17:31:44.435825 7f6195b24710 osd2 7 pg[0.f2( v 7'3 (0'0,7'3] n=1 ec=2 les=4 3/3/3) [2,0] r=0 mlcod 4'1 active+clean]    q front is repgather(0x2972d20 applied 7'2 rep_tid=134 wfack=0 wfdisk=0 op=osd_op(mds0.1:354 10000000001.000000a8 [delete] 0.3f2 snapc 1=[]) v1)
osd/ReplicatedPG.cc: In function 'void ReplicatedPG::eval_repop(ReplicatedPG::RepGather*)':
osd/ReplicatedPG.cc:2024: FAILED assert(repop_queue.front() == repop)
 ceph version 0.22 (commit:8a7c95f60ad0d821443721abf9779b8e2656ace8)
 1: (ReplicatedPG::repop_ack(ReplicatedPG::RepGather*, int, int, int, eversion_t)+0x168) [0x48c498]
 2: (ReplicatedPG::sub_op_modify_reply(MOSDSubOpReply*)+0x13c) [0x48c7bc]
 3: (OSD::dequeue_op(PG*)+0x112) [0x4e3c62]
 4: (ThreadPool::worker()+0x28f) [0x5c63ef]
 5: (ThreadPool::WorkThread::entry()+0xd) [0x4fc86d]
 6: (Thread::_entry_func(void*)+0xa) [0x46e28a]
 7: (()+0x68ba) [0x7f619ea808ba]
 8: (clone()+0x6d) [0x7f619da3401d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
*** Caught signal (ABRT) ***
 ceph version 0.22 (commit:8a7c95f60ad0d821443721abf9779b8e2656ace8)
 1: (sigabrt_handler(int)+0x7d) [0x5d7f5d]
 2: (()+0x321f0) [0x7f619d9971f0]
 3: (gsignal()+0x35) [0x7f619d997175]
 4: (abort()+0x180) [0x7f619d999f80]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f619e22adc5]
 6: (()+0xcb166) [0x7f619e229166]
 7: (()+0xcb193) [0x7f619e229193]
 8: (()+0xcb28e) [0x7f619e22928e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x448) [0x5c5d48]
 10: (ReplicatedPG::eval_repop(ReplicatedPG::RepGather*)+0x852) [0x48c1f2]
 11: (ReplicatedPG::repop_ack(ReplicatedPG::RepGather*, int, int, int, eversion_t)+0x168) [0x48c498]
 12: (ReplicatedPG::sub_op_modify_reply(MOSDSubOpReply*)+0x13c) [0x48c7bc]
 13: (OSD::dequeue_op(PG*)+0x112) [0x4e3c62]
 14: (ThreadPool::worker()+0x28f) [0x5c63ef]
 15: (ThreadPool::WorkThread::entry()+0xd) [0x4fc86d]
 16: (Thread::_entry_func(void*)+0xa) [0x46e28a]
 17: (()+0x68ba) [0x7f619ea808ba]
 18: (clone()+0x6d) [0x7f619da3401d]


MON LOG

2010-10-20 17:26:56.917695 7f0f21b33710 mon.1@1(peon).osd e5 e5: 6 osds: 5 up, 6 in
2010-10-20 17:26:58.287378 7f0f21b33710 mon.1@1(peon).osd e6 e6: 6 osds: 5 up, 6 in
2010-10-20 17:26:59.000052 7f0f21b33710 log [WRN] : lease_expire from mon0 was sent from future time 2010-10-20 17:26:59.965878 with expected time <=2010-10-20 17:26:59.010319, clocks not synchronized
2010-10-20 17:26:59.841789 7f0f21b33710 mon.1@1(peon).osd e7 e7: 6 osds: 5 up, 6 in
2010-10-20 17:32:01.136009 7f0f21b33710 mon.1@1(peon).osd e8 e8: 6 osds: 5 up, 5 in
2010-10-20 17:32:02.473756 7f0f21b33710 mon.1@1(peon).osd e9 e9: 6 osds: 5 up, 5 in
2010-10-20 17:32:03.617279 7f0f21b33710 mon.1@1(peon).osd e10 e10: 6 osds: 5 up, 5 in
2010-10-20 17:32:04.895345 7f0f21b33710 mon.1@1(peon).osd e11 e11: 6 osds: 5 up, 5 in
2010-10-20 17:32:06.080545 7f0f21b33710 mon.1@1(peon).osd e12 e12: 6 osds: 4 up, 5 in