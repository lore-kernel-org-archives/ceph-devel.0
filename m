From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: domino-style OSD crash
Date: Mon, 04 Jun 2012 10:44:35 +0200
Message-ID: <4FCC7573.3000704@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-loi.cpub.univ-nantes.fr ([193.52.103.112]:59727 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752823Ab2FDIom (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 04:44:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTP id 05392400D92
	for <ceph-devel@vger.kernel.org>; Mon,  4 Jun 2012 10:44:40 +0200 (CEST)
Received: from smtp-tls.univ-nantes.fr ([127.0.0.1])
	by localhost (smtptls1-loi.cpub.univ-nantes.fr [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0f2wasDaeiqU for <ceph-devel@vger.kernel.org>;
	Mon,  4 Jun 2012 10:44:36 +0200 (CEST)
Received: from [IPv6:2001:660:7220:0:7d02:54f6:a556:f8ce] (unknown [IPv6:2001:660:7220:0:7d02:54f6:a556:f8ce])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTPSA id 11C3B400EE5
	for <ceph-devel@vger.kernel.org>; Mon,  4 Jun 2012 10:44:36 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,
Besides the performance inconsistency (see other thread titled poor OSD=
=20
performance using kernel 3.4) where I promised some tests (will run thi=
s=20
afternoon), we tried this week-end to stress test ceph, making backups=20
with bacula on a rbd volume of 15T (8 osd nodes, using 8 physical machi=
nes)

Results : Worked like a charm during two days, apart btrfs warn message=
s=20
then OSD begin to crash 1 after all 'domino style'.

This morning, only 2 OSD of 8 are left.

1 of the physical machine was in kernel oops state - Nothing was remote=
=20
logged, don't know what happened, there were no clear stack message. I=20
suspect btrfs , but I have no proof.

This node (OSD.7) seems to have been the 1st one to crash, generated=20
reconstruction between OSD & then lead to the cascade osd crash.

The other physical machines are still up, but with no osd running. here=
=20
are some trace found in osd log :

    -3> 2012-06-03 12:43:32.524671 7ff1352b8700  0 log [WRN] : slow=20
request 30.506952 seconds old, rec
eived at 2012-06-03 12:43:01.997386: osd_sub_op(osd.0.0:1842628 2.57=20
ea8d5657/label5_17606_object7068/
head [push] v 191'628 snapset=3D0=3D[]:[] snapc=3D0=3D[]) v6 currently =
queued for pg
     -2> 2012-06-03 12:44:32.869852 7ff1352b8700  0 log [WRN] : 1 slow=20
requests, 1 included below; olde
st blocked for > 30.073136 secs
     -1> 2012-06-03 12:44:32.869886 7ff1352b8700  0 log [WRN] : slow=20
request 30.073136 seconds old, rec
eived at 2012-06-03 12:44:02.796651: osd_sub_op(osd.6.0:1837430 2.59=20
97e62059/rb.0.1.0000000a2cdf/head
  [push] v 1438'9416 snapset=3D0=3D[]:[] snapc=3D0=3D[]) v6 currently s=
tarted
      0> 2012-06-03 12:55:33.088034 7ff1237f6700 -1 *** Caught signal=20
(Aborted) **
  in thread 7ff1237f6700

  ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
  1: /usr/bin/ceph-osd() [0x708ea9]
  2: (()+0xeff0) [0x7ff13af2cff0]
  3: (gsignal()+0x35) [0x7ff13950b1b5]
  4: (abort()+0x180) [0x7ff13950dfc0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7ff139d9fdc5]
  6: (()+0xcb166) [0x7ff139d9e166]
  7: (()+0xcb193) [0x7ff139d9e193]
  8: (()+0xcb28e) [0x7ff139d9e28e]
  9: (std::__throw_length_error(char const*)+0x67) [0x7ff139d39307]
  10: (std::string::_Rep::_S_create(unsigned long, unsigned long,=20
std::allocator<char> const&)+0x72) [0x7ff139d7ab42]
  11: (()+0xa8565) [0x7ff139d7b565]
  12: (std::basic_string<char, std::char_traits<char>,=20
std::allocator<char> >::basic_string(char const*, unsigned long,=20
std::allocator<char> const&)+0x1b) [0x7ff139d7b7ab]
  13:=20
(leveldb::InternalKeyComparator::FindShortestSeparator(std::string*,=20
leveldb::Slice const&) const+0x4d) [0x6ef69d]
  14: (leveldb::TableBuilder::Add(leveldb::Slice const&, leveldb::Slice=
=20
const&)+0x9f) [0x6fdd9f]
  15:=20
(leveldb::DBImpl::DoCompactionWork(leveldb::DBImpl::CompactionState*)+0=
x4d3)=20
[0x6eaba3]
  16: (leveldb::DBImpl::BackgroundCompaction()+0x222) [0x6ebb02]
  17: (leveldb::DBImpl::BackgroundCall()+0x68) [0x6ec378]
  18: /usr/bin/ceph-osd() [0x704981]
  19: (()+0x68ca) [0x7ff13af248ca]
  20: (clone()+0x6d) [0x7ff1395a892d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

2 OSD exhibit similar traces.

---

4 other had traces like this one :

     -5> 2012-06-03 13:31:39.393489 7f74fd9c7700 -1 osd.3 1513=20
heartbeat_check: no reply from osd.5 sin
ce 2012-06-03 13:31:18.459792 (cutoff 2012-06-03 13:31:19.393488)
     -4> 2012-06-03 13:31:40.393689 7f74fd9c7700 -1 osd.3 1513=20
heartbeat_check: no reply from osd.5 sin
ce 2012-06-03 13:31:18.459792 (cutoff 2012-06-03 13:31:20.393687)
     -3> 2012-06-03 13:31:41.402873 7f74fd9c7700 -1 osd.3 1513=20
heartbeat_check: no reply from osd.5 sin
ce 2012-06-03 13:31:18.459792 (cutoff 2012-06-03 13:31:21.402872)
     -2> 2012-06-03 13:31:42.363270 7f74f08ac700 -1 osd.3 1513=20
heartbeat_check: no reply from osd.5 sin
ce 2012-06-03 13:31:18.459792 (cutoff 2012-06-03 13:31:22.363269)
     -1> 2012-06-03 13:31:42.416968 7f74fd9c7700 -1 osd.3 1513=20
heartbeat_check: no reply from osd.5 sin
ce 2012-06-03 13:31:18.459792 (cutoff 2012-06-03 13:31:22.416966)
      0> 2012-06-03 13:36:48.147020 7f74f58b6700 -1 osd/PG.cc: In=20
function 'void PG::merge_log(ObjectStore::Transaction&, pg_info_t&,=20
pg_log_t&, int)' thread 7f74f58b6700 time 2012-06-03 13:36:48.100157
osd/PG.cc: 402: FAILED assert(log.head >=3D olog.tail && olog.head >=3D=
=20
log.tail)

  ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
  1: (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,=20
int)+0x1eae) [0x649cce]
  2: (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec=20
const&)+0x2b1) [0x649fc1]
  3: (boost::statechart::simple_state<PG::RecoveryState::Stray,=20
PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0>::react_impl(boost::statechart::even=
t_base=20
const&, void const*)+0x203) [0x660343]
  4:=20
(boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,=20
PG::RecoveryState::Initial, std::allocator<void>,=20
boost::statechart::null_exception_translator>::process_event(boost::sta=
techart::event_base=20
const&)+0x6b) [0x6580eb]
  5: (PG::RecoveryState::handle_log(int, MOSDPGLog*,=20
PG::RecoveryCtx*)+0x190) [0x6139d0]
  6: (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5ce=
c66]
  7: (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5d312=
b]
  8: (OSD::_dispatch(Message*)+0x173) [0x5dc273]
  9: (OSD::ms_dispatch(Message*)+0x1e7) [0x5dcba7]
  10: (SimpleMessenger::dispatch_entry()+0x979) [0x7d60a9]
  11: (SimpleMessenger::DispatchThread::entry()+0xd) [0x72781d]
  12: (()+0x68ca) [0x7f75036338ca]
  13: (clone()+0x6d) [0x7f7501cb792d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

--- end dump of recent events ---
2012-06-03 13:36:48.487021 7f74f58b6700 -1 *** Caught signal (Aborted) =
**
  in thread 7f74f58b6700

  ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
  1: /usr/bin/ceph-osd() [0x708ea9]
  2: (()+0xeff0) [0x7f750363bff0]
  3: (gsignal()+0x35) [0x7f7501c1a1b5]
  4: (abort()+0x180) [0x7f7501c1cfc0]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f75024aedc5]
  6: (()+0xcb166) [0x7f75024ad166]
  7: (()+0xcb193) [0x7f75024ad193]
  8: (()+0xcb28e) [0x7f75024ad28e]
  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char=20
const*)+0x940) [0x77d550]
  10: (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,=20
int)+0x1eae) [0x649cce]
  11: (PG::RecoveryState::Stray::react(PG::RecoveryState::MLogRec=20
const&)+0x2b1) [0x649fc1]
  12: (boost::statechart::simple_state<PG::RecoveryState::Stray,=20
PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0>::react_impl(boost::statechart::even=
t_base=20
const&, void const*)+0x203) [0x660343]
  13:=20
(boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,=20
PG::RecoveryState::Initial, std::allocator<void>,=20
boost::statechart::null_exception_translator>::process_event(boost::sta=
techart::event_base=20
const&)+0x6b) [0x6580eb]
  14: (PG::RecoveryState::handle_log(int, MOSDPGLog*,=20
PG::RecoveryCtx*)+0x190) [0x6139d0]
  15: (OSD::handle_pg_log(std::tr1::shared_ptr<OpRequest>)+0x666) [0x5c=
ec66]
  16: (OSD::dispatch_op(std::tr1::shared_ptr<OpRequest>)+0x11b) [0x5d31=
2b]
  17: (OSD::_dispatch(Message*)+0x173) [0x5dc273]
  18: (OSD::ms_dispatch(Message*)+0x1e7) [0x5dcba7]
  19: (SimpleMessenger::dispatch_entry()+0x979) [0x7d60a9]
  20: (SimpleMessenger::DispatchThread::entry()+0xd) [0x72781d]
  21: (()+0x68ca) [0x7f75036338ca]
  22: (clone()+0x6d) [0x7f7501cb792d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

The root cause can be btrfs... or maybe not. I don't see any btrfs cras=
h=20
oops, just :

Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479173]=20
Pid: 16875, comm: kworker/7:0 Tainted: G        W    3.4.0-dsiun-120521=
 #108
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479218]=20
Call Trace:
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479243]=20
[<ffffffff81039f1b>] ? warn_slowpath_common+0x7b/0xc0
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479278]=20
[<ffffffffa026fca5>] ? btrfs_orphan_commit_root+0x105/0x110 [btrfs]
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479328]=20
[<ffffffffa026965a>] ? commit_fs_roots.isra.22+0xaa/0x170 [btrfs]
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479379]=20
[<ffffffffa02bc9a0>] ? btrfs_scrub_pause+0xf0/0x100 [btrfs]
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479415]=20
[<ffffffffa026a6f1>] ? btrfs_commit_transaction+0x521/0x9d0 [btrfs]
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479460]=20
[<ffffffff8105a9f0>] ? add_wait_queue+0x60/0x60
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479493]=20
[<ffffffffa026aba0>] ? btrfs_commit_transaction+0x9d0/0x9d0 [btrfs]
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479543]=20
[<ffffffffa026abb1>] ? do_async_commit+0x11/0x20 [btrfs]
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479572]=20
[<ffffffff810548a7>] ? process_one_work+0x107/0x460
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479601]=20
[<ffffffff81055a8e>] ? worker_thread+0x14e/0x330
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479628]=20
[<ffffffff81055940>] ? manage_workers.isra.28+0x210/0x210
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479657]=20
[<ffffffff8105a005>] ? kthread+0x85/0x90
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479684]=20
[<ffffffff813be3e4>] ? kernel_thread_helper+0x4/0x10
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479712]=20
[<ffffffff81059f80>] ? kthread_freezable_should_stop+0x60/0x60
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479741]=20
[<ffffffff813be3e0>] ? gs_change+0x13/0x13
Jun  2 23:40:03 chichibu.u14.univ-nantes.prive kernel: [200652.479767]=20
---[ end trace 303c47aab4b5d025 ]---
Jun  3 00:44:11 chichibu.u14.univ-nantes.prive kernel: [204497.711101]=20
------------[ cut here ]------------

But this is just a warn (maybe that could lead to kernel oops/crash).=20
Seems to have been fixed lately in git kernels.


I can give you all 8 logs of OSD + logs of MDS & MON if it can help.


Cheers,
--

Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
