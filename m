From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: ceph-osd crash
Date: Wed, 6 Sep 2017 22:34:40 -0400
Message-ID: <CAGbvivKv_hyJGpOv5ttFtOpdDvrMAUW-hDtW2+u-hv6fYFSd6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35143 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbdIGCel (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Sep 2017 22:34:41 -0400
Received: by mail-io0-f180.google.com with SMTP id i14so1275830ioe.2
        for <ceph-devel@vger.kernel.org>; Wed, 06 Sep 2017 19:34:41 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Jewel 10.2.7 on Ubuntu 16.04.2,

I have an OSD that keeps going down, these are the messages in the
log.  Is this a known bug?

    -3> 2017-09-06 22:33:14.509181 7f7e18429700  5 osd.16 pg_epoch:
107818 pg[9.cd( v 35684'19200 (35250'16102,35684'19200]
local-les=107801 n=17 ec=1076 les/c/f 107801/107802/0
107816/107818/107818) [16,1,65] r=0 lpr=107818 pi=107484-107817/30
crt=35684'19200 lcod 0'0 mlcod 0'0 peering] exit
Started/Primary/Peering/GetMissing 0.000008 0 0.000000
    -2> 2017-09-06 22:33:14.509193 7f7e18429700  5 osd.16 pg_epoch:
107818 pg[9.cd( v 35684'19200 (35250'16102,35684'19200]
local-les=107801 n=17 ec=1076 les/c/f 107801/107802/0
107816/107818/107818) [16,1,65] r=0 lpr=107818 pi=107484-107817/30
crt=35684'19200 lcod 0'0 mlcod 0'0 peering] enter
Started/Primary/Peering/WaitUpThru
    -1> 2017-09-06 22:33:14.525481 7f7e9cb37700  1 leveldb: Level-0
table #803535: 2374544 bytes OK
     0> 2017-09-06 22:33:14.526739 7f7e19c2c700 -1 *** Caught signal
(Aborted) **
 in thread 7f7e19c2c700 thread_name:tp_osd

 ceph version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185)
 1: (()+0x9770ae) [0x56326b73d0ae]
 2: (()+0x11390) [0x7f7ea9c64390]
 3: (gsignal()+0x38) [0x7f7ea7c02428]
 4: (abort()+0x16a) [0x7f7ea7c0402a]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x26b) [0x56326b83d54b]
 6: (PGLog::merge_log(ObjectStore::Transaction&, pg_info_t&,
pg_log_t&, pg_shard_t, pg_info_t&, PGLog::LogEntryHandler*, bool&,
bool&)+0x1a12) [0x56326b3f5ff2]
 7: (PG::merge_log(ObjectStore::Transaction&, pg_info_t&, pg_log_t&,
pg_shard_t)+0xcd) [0x56326b2034ad]
 8: (PG::proc_master_log(ObjectStore::Transaction&, pg_info_t&,
pg_log_t&, pg_missing_t&, pg_shard_t)+0xc8) [0x56326b20d948]
 9: (PG::RecoveryState::GetLog::react(PG::RecoveryState::GotLog
const&)+0x1e7) [0x56326b22faf7]
 10: (boost::statechart::simple_state<PG::RecoveryState::GetLog,
PG::RecoveryState::Peering, boost::mpl::list<mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
const&, void const*)+0x1fe) [0x56326b271d1e]
 11: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
PG::RecoveryState::Initial, std::allocator<void>,
boost::statechart::null_exception_translator>::process_queued_events()+0x131)
[0x56326b24f891]
 12: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
PG::RecoveryState::Initial, std::allocator<void>,
boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
const&)+0xee) [0x56326b24fdce]
 13: (PG::handle_peering_event(std::shared_ptr<PG::CephPeeringEvt>,
PG::RecoveryCtx*)+0x395) [0x56326b223025]
 14: (OSD::process_peering_events(std::__cxx11::list<PG*,
std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x2d4)
[0x56326b16fdf4]
 15: (ThreadPool::BatchWorkQueue<PG>::_void_process(void*,
ThreadPool::TPHandle&)+0x25) [0x56326b1b88e5]
 16: (ThreadPool::worker(ThreadPool::WorkThread*)+0xdb1) [0x56326b82f531]
 17: (ThreadPool::WorkThread::entry()+0x10) [0x56326b830630]
 18: (()+0x76ba) [0x7f7ea9c5a6ba]
 19: (clone()+0x6d) [0x7f7ea7cd382d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
