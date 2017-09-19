From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: OSD crashes (10.2.9)
Date: Tue, 19 Sep 2017 13:16:48 -0400
Message-ID: <CAGbvivLQEv6DYqeE-cJqYO57m8ih0ViKUgQXUF7C7f_TM-Tz5w@mail.gmail.com>
References: <CAGbviv+ivLU6om240hEn=ajGogLYdR1XRmnEaFDYWHyaEzXZWw@mail.gmail.com>
 <alpine.DEB.2.11.1709191707410.4417@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:51561 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdISRQu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Sep 2017 13:16:50 -0400
Received: by mail-lf0-f48.google.com with SMTP id y187so278754lfc.8
        for <ceph-devel@vger.kernel.org>; Tue, 19 Sep 2017 10:16:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709191707410.4417@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

It appears to just be getting an abort signal, I dont see any other assertions.



--- begin dump of recent events ---
   -40> 2017-09-19 12:18:26.520895 7f2d927bd700  5 osd.81 pg_epoch:
239987 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239984/233424) [62,81,74]/[62,29,74]
r=-1 lpr=239984 pi=178346-239983/179 crt=0'0 remapped NOTIFY] exit
Started/Stray 7.133544 10 0.000349
   -39> 2017-09-19 12:18:26.520976 7f2d927bd700  5 osd.81 pg_epoch:
239987 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239984/233424) [62,81,74]/[62,29,74]
r=-1 lpr=239984 pi=178346-239983/179 crt=0'0 remapped NOTIFY] exit
Started 7.133652 0 0.000000
   -38> 2017-09-19 12:18:26.520984 7f2d927bd700  5 osd.81 pg_epoch:
239987 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239984/233424) [62,81,74]/[62,29,74]
r=-1 lpr=239984 pi=178346-239983/179 crt=0'0 remapped NOTIFY] enter
Reset
   -37> 2017-09-19 12:18:26.521294 7f2d93fc0700  5 write_log with:
dirty_to: 4294967295'18446744073709551615, dirty_from:
4294967295'18446744073709551615, dirty_divergent_priors: true,
divergent_priors: 0, writeout_from: 4294967295'18446744073709551615,
trimmed:
   -36> 2017-09-19 12:18:26.521885 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239984/236323) [72,81,88]/[72,95,88]
r=-1 lpr=239984 pi=172390-239983/422 crt=0'0 remapped NOTIFY] exit
Started/Stray 7.126071 12 0.000463
   -35> 2017-09-19 12:18:26.521901 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239984/236323) [72,81,88]/[72,95,88]
r=-1 lpr=239984 pi=172390-239983/422 crt=0'0 remapped NOTIFY] exit
Started 7.126112 0 0.000000
   -34> 2017-09-19 12:18:26.521907 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239984/236323) [72,81,88]/[72,95,88]
r=-1 lpr=239984 pi=172390-239983/422 crt=0'0 remapped NOTIFY] enter
Reset
   -33> 2017-09-19 12:18:26.523389 7f2d927bd700  5 osd.81 pg_epoch:
239989 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239987/233424) [62,81,74]/[62,74,29]
r=-1 lpr=239987 pi=178346-239986/180 crt=0'0 remapped NOTIFY] exit
Reset 0.002402 3 0.000578
   -32> 2017-09-19 12:18:26.523499 7f2d927bd700  5 osd.81 pg_epoch:
239989 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239987/233424) [62,81,74]/[62,74,29]
r=-1 lpr=239987 pi=178346-239986/180 crt=0'0 remapped NOTIFY] enter
Started
   -31> 2017-09-19 12:18:26.523537 7f2d927bd700  5 osd.81 pg_epoch:
239989 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239987/233424) [62,81,74]/[62,74,29]
r=-1 lpr=239987 pi=178346-239986/180 crt=0'0 remapped NOTIFY] enter
Start
   -30> 2017-09-19 12:18:26.523572 7f2d927bd700  1 osd.81 pg_epoch:
239989 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239987/233424) [62,81,74]/[62,74,29]
r=-1 lpr=239987 pi=178346-239986/180 crt=0'0 remapped NOTIFY]
state<Start>: transitioning to Stray
   -29> 2017-09-19 12:18:26.523619 7f2d927bd700  5 osd.81 pg_epoch:
239989 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239987/233424) [62,81,74]/[62,74,29]
r=-1 lpr=239987 pi=178346-239986/180 crt=0'0 remapped NOTIFY] exit
Start 0.000081 0 0.000000
   -28> 2017-09-19 12:18:26.523657 7f2d927bd700  5 osd.81 pg_epoch:
239989 pg[22.15b( empty lb MIN (bitwise) local-les=194057 n=0 ec=19250
les/c/f 239869/239869/0 239984/239987/233424) [62,81,74]/[62,74,29]
r=-1 lpr=239987 pi=178346-239986/180 crt=0'0 remapped NOTIFY] enter
Started/Stray
   -27> 2017-09-19 12:18:26.524220 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239989/236323) [72,81,88]/[72,88,95]
r=-1 lpr=239989 pi=172390-239988/423 crt=0'0 remapped NOTIFY] exit
Reset 0.002312 1 0.000056
   -26> 2017-09-19 12:18:26.524230 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239989/236323) [72,81,88]/[72,88,95]
r=-1 lpr=239989 pi=172390-239988/423 crt=0'0 remapped NOTIFY] enter
Started
   -25> 2017-09-19 12:18:26.524235 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239989/236323) [72,81,88]/[72,88,95]
r=-1 lpr=239989 pi=172390-239988/423 crt=0'0 remapped NOTIFY] enter
Start
   -24> 2017-09-19 12:18:26.524258 7f2d937bf700  1 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239989/236323) [72,81,88]/[72,88,95]
r=-1 lpr=239989 pi=172390-239988/423 crt=0'0 remapped NOTIFY]
state<Start>: transitioning to Stray
   -23> 2017-09-19 12:18:26.524297 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239989/236323) [72,81,88]/[72,88,95]
r=-1 lpr=239989 pi=172390-239988/423 crt=0'0 remapped NOTIFY] exit
Start 0.000060 0 0.000000
   -22> 2017-09-19 12:18:26.524332 7f2d937bf700  5 osd.81 pg_epoch:
239989 pg[10.19d( empty lb MIN (bitwise) local-les=194033 n=0 ec=1077
les/c/f 239874/239878/0 239984/239989/236323) [72,81,88]/[72,88,95]
r=-1 lpr=239989 pi=172390-239988/423 crt=0'0 remapped NOTIFY] enter
Started/Stray
   -21> 2017-09-19 12:18:26.585924 7f2d82937700  1 --
10.3.1.105:6817/45761 <== osd.4 10.16.51.102:0/558150 2 ====
osd_ping(ping e239991 stamp 2017-09-19 12:18:26.584753) v2 ==== 47+0+0
(722370431 0 0) 0x561d02827600 con 0x561d02b49900
   -20> 2017-09-19 12:18:26.585966 7f2d82937700  1 --
10.3.1.105:6817/45761 --> 10.16.51.102:0/558150 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.584753) v2 -- ?+0 0x561d02827c00 con
0x561d02b49900
   -19> 2017-09-19 12:18:26.585926 7f2d82836700  1 --
10.16.51.105:6817/45761 <== osd.4 10.16.51.102:0/558150 2 ====
osd_ping(ping e239991 stamp 2017-09-19 12:18:26.584753) v2 ==== 47+0+0
(722370431 0 0) 0x561d02827800 con 0x561d04b7e000
   -18> 2017-09-19 12:18:26.586004 7f2d82836700  1 --
10.16.51.105:6817/45761 --> 10.16.51.102:0/558150 --
osd_ping(ping_reply e239989 stamp 2017-09-19 12:18:26.584753) v2 --
?+0 0x561d02828000 con 0x561d04b7e000
   -17> 2017-09-19 12:18:26.598246 7f2d61cb1700  1 --
10.3.1.105:6817/45761 <== osd.31 10.3.1.102:0/555749 2 ====
osd_ping(ping e239991 stamp 2017-09-19 12:18:26.597198) v2 ==== 47+0+0
(2473246502 0 0) 0x561d02828200 con 0x561d030e5780
   -16> 2017-09-19 12:18:26.598274 7f2d61cb1700  1 --
10.3.1.105:6817/45761 --> 10.3.1.102:0/555749 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.597198) v2 -- ?+0 0x561d02828800 con
0x561d030e5780
   -15> 2017-09-19 12:18:26.598481 7f2d61db2700  1 --
10.16.51.105:6817/45761 <== osd.31 10.3.1.102:0/555749 2 ====
osd_ping(ping e239991 stamp 2017-09-19 12:18:26.597198) v2 ==== 47+0+0
(2473246502 0 0) 0x561d02828400 con 0x561d02ebac00
   -14> 2017-09-19 12:18:26.598495 7f2d61db2700  1 --
10.16.51.105:6817/45761 --> 10.3.1.102:0/555749 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.597198) v2 -- ?+0 0x561d02828c00 con
0x561d02ebac00
   -13> 2017-09-19 12:18:26.664660 7f2d6b9c9700  1 --
10.3.1.105:6817/45761 <== osd.25 10.16.51.102:0/591839 3 ====
osd_ping(ping e239990 stamp 2017-09-19 12:18:26.663309) v2 ==== 47+0+0
(174834353 0 0) 0x561a9072ae00 con 0x561d01150400
   -12> 2017-09-19 12:18:26.664669 7f2d6b8c8700  1 --
10.16.51.105:6817/45761 <== osd.25 10.16.51.102:0/591839 3 ====
osd_ping(ping e239990 stamp 2017-09-19 12:18:26.663309) v2 ==== 47+0+0
(174834353 0 0) 0x561d02bd2200 con 0x561d01150b80
   -11> 2017-09-19 12:18:26.664685 7f2d6b9c9700  1 --
10.3.1.105:6817/45761 --> 10.16.51.102:0/591839 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.663309) v2 -- ?+0 0x561ac20a0800 con
0x561d01150400
   -10> 2017-09-19 12:18:26.664712 7f2d6b8c8700  1 --
10.16.51.105:6817/45761 --> 10.16.51.102:0/591839 --
osd_ping(ping_reply e239989 stamp 2017-09-19 12:18:26.663309) v2 --
?+0 0x561d261f7c00 con 0x561d01150b80
    -9> 2017-09-19 12:18:26.668533 7f2d63797700  1 --
10.16.51.105:6817/45761 <== osd.10 10.16.51.101:0/314610 4 ====
osd_ping(ping e239991 stamp 2017-09-19 12:18:26.667188) v2 ==== 47+0+0
(968170766 0 0) 0x561d07ced000 con 0x561d02d8f800
    -8> 2017-09-19 12:18:26.668556 7f2d63797700  1 --
10.16.51.105:6817/45761 --> 10.16.51.101:0/314610 --
osd_ping(ping_reply e239989 stamp 2017-09-19 12:18:26.667188) v2 --
?+0 0x561cfd02e800 con 0x561d02d8f800
    -7> 2017-09-19 12:18:26.674422 7f2e07129700  1 --
10.3.1.105:6817/45761 <== osd.10 10.16.51.101:0/314610 4 ====
osd_ping(ping e239991 stamp 2017-09-19 12:18:26.667188) v2 ==== 47+0+0
(968170766 0 0) 0x561d07ceda00 con 0x561a9acff180
    -6> 2017-09-19 12:18:26.674442 7f2e07129700  1 --
10.3.1.105:6817/45761 --> 10.16.51.101:0/314610 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.667188) v2 -- ?+0 0x561cfd02e200 con
0x561a9acff180
    -5> 2017-09-19 12:18:26.682821 7f2d9efd6700  1 --
10.16.51.105:6816/45761 <== mon.2 10.16.51.23:6789/0 20 ====
osd_map(239990..239992 src has 198325..239992) v3 ==== 1217+0+0
(3438528651 0 0) 0x561d04adac80 con 0x561cf9548c00
    -4> 2017-09-19 12:18:26.816837 7f2dccac0700  1 --
10.3.1.105:6817/45761 <== osd.43 10.3.1.103:0/509597 2 ====
osd_ping(ping e239990 stamp 2017-09-19 12:18:26.813161) v2 ==== 47+0+0
(1181431656 0 0) 0x561d2437c400 con 0x561d02ebb080
    -3> 2017-09-19 12:18:26.816862 7f2dccac0700  1 --
10.3.1.105:6817/45761 --> 10.3.1.103:0/509597 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.813161) v2 -- ?+0 0x561d2437c800 con
0x561d02ebb080
    -2> 2017-09-19 12:18:26.816895 7f2dc336d700  1 --
10.16.51.105:6817/45761 <== osd.43 10.3.1.103:0/509597 2 ====
osd_ping(ping e239990 stamp 2017-09-19 12:18:26.813161) v2 ==== 47+0+0
(1181431656 0 0) 0x561d2437be00 con 0x561d030c8880
    -1> 2017-09-19 12:18:26.816904 7f2dc336d700  1 --
10.16.51.105:6817/45761 --> 10.3.1.103:0/509597 -- osd_ping(ping_reply
e239989 stamp 2017-09-19 12:18:26.813161) v2 -- ?+0 0x561d2437c200 con
0x561d030c8880
     0> 2017-09-19 12:18:26.842937 7f2d95fc4700 -1 *** Caught signal
(Aborted) **
 in thread 7f2d95fc4700 thread_name:tp_osd

 ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
 1: (()+0x984c4e) [0x561a4df72c4e]
 2: (()+0x11390) [0x7f2e23d10390]
 3: (gsignal()+0x38) [0x7f2e21cae428]
 4: (abort()+0x16a) [0x7f2e21cb002a]
 5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x26b) [0x561a4e0730db]
 6: (PG::RecoveryState::Stray::react(PG::MLogRec const&)+0x2e6) [0x561a4da6e706]
 7: (boost::statechart::simple_state<PG::RecoveryState::Stray,
PG::RecoveryState::Started, boost::mpl::list<mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
const&, void const*)+0x33e) [0x561a4da9f1ce]
 8: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
PG::RecoveryState::Initial, std::allocator<void>,
boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
const&)+0x69) [0x561a4da7f229]
 9: (PG::handle_peering_event(std::shared_ptr<PG::CephPeeringEvt>,
PG::RecoveryCtx*)+0x395) [0x561a4da52cb5]
 10: (OSD::process_peering_events(std::__cxx11::list<PG*,
std::allocator<PG*> > const&, ThreadPool::TPHandle&)+0x2d4)
[0x561a4d99e854]
 11: (ThreadPool::BatchWorkQueue<PG>::_void_process(void*,
ThreadPool::TPHandle&)+0x25) [0x561a4d9e74c5]
 12: (ThreadPool::worker(ThreadPool::WorkThread*)+0xdb1) [0x561a4e0650c1]
 13: (ThreadPool::WorkThread::entry()+0x10) [0x561a4e0661c0]
 14: (()+0x76ba) [0x7f2e23d066ba]
 15: (clone()+0x6d) [0x7f2e21d7f82d]
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
   0/ 1 leveldb
   1/ 5 kinetic
   1/ 5 fuse
  99/99 (syslog threshold)
  -1/-1 (stderr threshold)
  max_recent     10000
  max_new         1000
  log_file /var/log/ceph/ceph-osd.81.log
--- end dump of recent events ---



On Tue, Sep 19, 2017 at 1:08 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 19 Sep 2017, Wyllys Ingersoll wrote:
>> Im seeing this stack trace in a lot of my OSDs (21 out of 92).  I
>> suspect its a corrupt leveldb or journal, but not sure how to debug it
>> further.  Any suggestions on how to debug further?
>>
>>  ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
>>  1: (()+0x984c4e) [0x56032b65ec4e]
>>  2: (()+0x11390) [0x7f89adce8390]
>>  3: (gsignal()+0x38) [0x7f89abc86428]
>>  4: (abort()+0x16a) [0x7f89abc8802a]
>>  5: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x26b) [0x56032b75f0db]
>
> The assertion itself is a few lines earlier in the log.. can you include
> that please?
>
> Thanks!
> sage
>
>>  6: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d const*, char
>> const*, long)+0x259) [0x56032b69b2d9]
>>  7: (ceph::HeartbeatMap::is_healthy()+0xe6) [0x56032b69bc06]
>>  8: (ceph::HeartbeatMap::check_touch_file()+0x2c) [0x56032b69c45c]
>>  9: (CephContextServiceThread::entry()+0x167) [0x56032b777777]
>>  10: (()+0x76ba) [0x7f89adcde6ba]
>>  11: (clone()+0x6d) [0x7f89abd5782d]
>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
