From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: OSD crashes (10.2.9)
Date: Tue, 19 Sep 2017 13:28:47 -0400
Message-ID: <CAGbvivLd_cVMy1Dsi8nybtxCXNJXtBSMR_pjsThSQ_JEwWojpQ@mail.gmail.com>
References: <CAGbviv+ivLU6om240hEn=ajGogLYdR1XRmnEaFDYWHyaEzXZWw@mail.gmail.com>
 <alpine.DEB.2.11.1709191707410.4417@piezo.novalocal> <CAGbvivLQEv6DYqeE-cJqYO57m8ih0ViKUgQXUF7C7f_TM-Tz5w@mail.gmail.com>
 <alpine.DEB.2.11.1709191717510.4417@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:43978 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdISR2u (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 13:28:50 -0400
Received: by mail-lf0-f41.google.com with SMTP id c80so348015lfh.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 10:28:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709191717510.4417@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hows this?


   -15> 2017-09-19 12:18:26.517719 7f2d9d7d3700  1 --
10.3.1.105:6816/45761 <== osd.45 10.3.1.105:6800/2648 13 ====
pg_log(7.a8 epoch 239985 log log((18780'92006,31991'95006],
crt=31991'95006) query_epoch 239985) v4 ==== 529591+0+0 (953547831 0
0) 0x561d172fe700 con 0x561cffb0a780
   -14> 2017-09-19 12:18:26.517727 7f2d9d7d3700  5 -- op tracker --
seq: 1179, time: 2017-09-19 12:18:26.517727, event: started, op:
pg_log(7.a8 epoch 239985 log log((18780'92006,31991'95006],
crt=31991'95006) query_epoch 239985)
   -13> 2017-09-19 12:18:26.517807 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8(unlocked)] enter Initial
   -12> 2017-09-19 12:18:26.517854 7f2d9d7d3700  5 write_log with:
dirty_to: 0'0, dirty_from: 4294967295'18446744073709551615,
dirty_divergent_priors: false, divergent_priors: 0, writeout_from:
4294967295'18446744073709551615, trimmed:
   -11> 2017-09-19 12:18:26.517863 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=0
pi=232839-239983/18 crt=0'0 inactive] exit Initial 0.000056 0 0.000000
   -10> 2017-09-19 12:18:26.517873 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=0
pi=232839-239983/18 crt=0'0 inactive] enter Reset
    -9> 2017-09-19 12:18:26.517880 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=239985
pi=232839-239983/18 crt=0'0 inactive] exit Reset 0.000006 1 0.000016
    -8> 2017-09-19 12:18:26.517885 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=239985
pi=232839-239983/18 crt=0'0 inactive] enter Started
    -7> 2017-09-19 12:18:26.517889 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=239985
pi=232839-239983/18 crt=0'0 inactive] enter Start
    -6> 2017-09-19 12:18:26.517893 7f2d9d7d3700  1 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=239985
pi=232839-239983/18 crt=0'0 inactive] state<Start>: transitioning to
Stray
    -5> 2017-09-19 12:18:26.517898 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=239985
pi=232839-239983/18 crt=0'0 inactive] exit Start 0.000008 0 0.000000
    -4> 2017-09-19 12:18:26.517903 7f2d9d7d3700  5 osd.81 pg_epoch:
239985 pg[7.a8( empty local-les=0 n=0 ec=961 les/c/f 239883/232911/0
239984/239984/234230) [83,81,38]/[45,74,80] r=-1 lpr=239985
pi=232839-239983/18 crt=0'0 inactive] enter Started/Stray
    -3> 2017-09-19 12:18:26.520197 7f2d93fc0700  5 osd.81 pg_epoch:
239989 pg[1.6b3( v 219971'243654 (215190'240654,219971'243654] lb MIN
(bitwise) local-les=239985 n=0 ec=23117 les/c/f 239868/239869/0
239984/239984/234718) [81,63,73]/[40,39,45] r=-1 lpr=239985
pi=239867-239983/1 crt=0'0 lcod 0'0 inactive] exit Started/Stray
0.009491 6 0.000045
   -2> 2017-09-19 12:18:26.520215 7f2d93fc0700  5 osd.81 pg_epoch:
239989 pg[1.6b3( v 219971'243654 (215190'240654,219971'243654] lb MIN
(bitwise) local-les=239985 n=0 ec=23117 les/c/f 239868/239869/0
239984/239984/234718) [81,63,73]/[40,39,45] r=-1 lpr=239985
pi=239867-239983/1 crt=0'0 lcod 0'0 inactive] enter
Started/ReplicaActive
    -1> 2017-09-19 12:18:26.520223 7f2d93fc0700  5 osd.81 pg_epoch:
239989 pg[1.6b3( v 219971'243654 (215190'240654,219971'243654] lb MIN
(bitwise) local-les=239985 n=0 ec=23117 les/c/f 239868/239869/0
239984/239984/234718) [81,63,73]/[40,39,45] r=-1 lpr=239985
pi=239867-239983/1 crt=0'0 lcod 0'0 inactive] enter
Started/ReplicaActive/RepNotRecovering
     0> 2017-09-19 12:18:26.520292 7f2d95fc4700 -1 osd/PGLog.h: In
function 'void PGLog::IndexedLog::claim_log_and_clear_rollback_info(const
pg_log_t&)' thread 7f2d95fc4700 time 2017-09-19 12:18:26.515587
osd/PGLog.h: 110: FAILED assert(rollback_info_trimmed_to == head)

 ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x80) [0x561a4e072ef0]
 2: (PG::RecoveryState::Stray::react(PG::MLogRec const&)+0x2e6) [0x561a4da6e706]
 3: (boost::statechart::simple_state<PG::RecoveryState::Stray,
PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
const&, void const*)+0x33e) [0x561a4da9f1ce]
 4: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
PG::RecoveryState::Initial, std::allocator<void>,
boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
const&)+0x69) [0x561a4da7f229]
 5: (PG::handle_peering_event(std::shared_ptr<PG::CephPeeringEvt>,
PG::RecoveryCtx*)+0x395) [0x561a4da52cb5]
 6: (OSD::process_peering_events(std::__cxx11::list<PG*,
std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x2d4)
[0x561a4d99e854]
 7: (ThreadPool::BatchWorkQueue<PG>::_void_process(void*,
ThreadPool::TPHandle&)+0x25) [0x561a4d9e74c5]
 8: (ThreadPool::worker(ThreadPool::WorkThread*)+0xdb1) [0x561a4e0650c1]
 9: (ThreadPool::WorkThread::entry()+0x10) [0x561a4e0661c0]
 10: (()+0x76ba) [0x7f2e23d066ba]
 11: (clone()+0x6d) [0x7f2e21d7f82d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.


On Tue, Sep 19, 2017 at 1:18 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 19 Sep 2017, Wyllys Ingersoll wrote:
>> It appears to just be getting an abort signal, I dont see any other assertions.
>
> It may be a ways up in the log if the OSD was busy.  Search for the thread
> id from this line
>
>>      0> 2017-09-19 12:18:26.842937 7f2d95fc4700 -1 *** Caught signal
>> (Aborted) **
>>  in thread 7f2d95fc4700 thread_name:tp_osd
>
> (7f2d95fc4700 in this case) backwards to find the failed assertion message.
>
> Thanks!
> sage
