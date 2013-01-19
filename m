From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Sat, 19 Jan 2013 19:40:43 +0100
Message-ID: <50FAE8AB.5000602@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx04.stofanet.dk ([212.10.10.14]:50518 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab3ASSkt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 19 Jan 2013 13:40:49 -0500
In-Reply-To: <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

> Do you have a full log for this?

I upped the log level and started the osd again.

It ran for 23 seconds and then suddenly crashed out of the blue.

The last log lines were:

2013-01-19 19:31:39.975475 7f50de7fc700 10 osd.2 pg_epoch: 416 pg[0.fc(=
=20
v 164'38593 (164'37592,164'38593] local-les=3D247 n=3D2622 ec=3D1 les/c=
=20
247/156 379/379/379) [1,3] r=3D-1 lpr=3D379 pi=3D152-378/14 lcod 0'0 in=
active=20
NOTIFY] state<Reset>: Reset advmap
2013-01-19 19:31:39.975483 7f50de7fc700 10 osd.2 pg_epoch: 416 pg[0.fc(=
=20
v 164'38593 (164'37592,164'38593] local-les=3D247 n=3D2622 ec=3D1 les/c=
=20
247/156 379/379/379) [1,3] r=3D-1 lpr=3D379 pi=3D152-378/14 lcod 0'0 in=
active=20
NOTIFY] _calc_past_interval_range: already have past intervals back to =
156
2013-01-19 19:31:39.975495 7f50de7fc700 10 osd.2 pg_epoch: 416 pg[0.fc(=
=20
v 164'38593 (164'37592,164'38593] local-les=3D247 n=3D2622 ec=3D1 les/c=
=20
247/156 379/379/379) [1,3] r=3D-1 lpr=3D379 pi=3D152-378/14 lcod 0'0 in=
active=20
NOTIFY] handle_advance_map [1,3]/[1,3]
2013-01-19 19:31:39.975505 7f50de7fc700 10 osd.2 pg_epoch: 417 pg[0.fc(=
=20
v 164'38593 (164'37592,164'38593] local-les=3D247 n=3D2622 ec=3D1 les/c=
=20
247/156 379/379/379) [1,3] r=3D-1 lpr=3D379 pi=3D152-378/14 lcod 0'0 in=
active=20
NOTIFY] state<Reset>: Reset advmap
2013-01-19 19:31:39.975513 7f50de7fc700 10


The stack trace from the core file shows:

Program terminated with signal 6, Aborted.
#0  0x000000360de0eebb in raise () from /lib64/libpthread.so.0
Missing separate debuginfos, use: debuginfo-install=20
boost-thread-1.48.0-13.fc17.x86_64 glibc-2.15-57.fc17.x86_64=20
libaio-0.3.109-5.fc17.x86_64 libgcc-4.7.2-2.fc17.x86_64=20
libstdc++-4.7.2-2.fc17.x86_64 libuuid-2.21.2-2.fc17.x86_64=20
nspr-4.9.2-1.fc17.x86_64 nss-3.13.5-1.fc17.x86_64=20
nss-softokn-3.13.5-1.fc17.x86_64 nss-softokn-freebl-3.13.5-1.fc17.x86_6=
4=20
nss-util-3.13.5-1.fc17.x86_64 sqlite-3.7.11-3.fc17.x86_64
(gdb) bt
#0  0x000000360de0eebb in raise () from /lib64/libpthread.so.0
#1  0x000000000082f7a6 in reraise_fatal (signum=3D6) at=20
global/signal_handler.cc:58
#2  handle_fatal_signal (signum=3D6) at global/signal_handler.cc:104
#3  <signal handler called>
#4  0x000000360d635925 in raise () from /lib64/libc.so.6
#5  0x000000360d6370d8 in abort () from /lib64/libc.so.6
#6  0x0000003611660dad in __gnu_cxx::__verbose_terminate_handler() ()=20
from /lib64/libstdc++.so.6
#7  0x000000361165eea6 in ?? () from /lib64/libstdc++.so.6
#8  0x000000361165eed3 in std::terminate() () from /lib64/libstdc++.so.=
6
#9  0x000000361165f0fe in __cxa_throw () from /lib64/libstdc++.so.6
#10 0x00000000008d5edd in ceph::__ceph_assert_fail (assertion=3D0x99b1b=
8=20
"exists(osd)", file=3D<optimized out>, line=3D367, func=3D0x99fa20 "con=
st=20
epoch_t& OSDMap::get_up_thru(int) const") at common/assert.cc:77
#11 0x000000000060db42 in OSDMap::get_up_thru (osd=3D<optimized out>,=20
this=3D<optimized out>) at osd/OSDMap.h:367
#12 0x00000000006e3b35 in OSDMap::get_up_thru (this=3D<optimized out>,=20
osd=3D<optimized out>) at osd/OSDMap.h:369
#13 0x0000000000935590 in pg_interval_t::check_new_interval=20
(old_acting=3D..., new_acting=3D..., old_up=3D..., new_up=3D...,=20
same_interval_since=3D553, last_epoch_clean=3D425,=20
osdmap=3Dstd::tr1::shared_ptr (count 83, weak 1) 0x2d59530,
     lastmap=3Dstd::tr1::shared_ptr (count 59, weak 1) 0x2e85650,=20
pool_id=3D0, pgid=3D..., past_intervals=3D0xc62ef78, out=3D0x0) at=20
osd/osd_types.cc:1537
#14 0x00000000007563c3 in PG::start_peering_interval=20
(this=3Dthis@entry=3D0xc62e880, lastmap=3Dstd::tr1::shared_ptr (count 5=
9, weak=20
1) 0x2e85650, newup=3Dstd::vector of length 2, capacity 2 =3D {...},=20
newacting=3Dstd::vector of length 3, capacity 3 =3D {...}) at osd/PG.cc=
:4624
#15 0x000000000075887e in PG::RecoveryState::Reset::react=20
(this=3Dthis@entry=3D0x9581270, advmap=3D...) at osd/PG.cc:5241
#16 0x000000000078abb6 in react<PG::RecoveryState::Reset,=20
boost::statechart::event_base, void const*> (evt=3D..., stt=3D...,=20
eventType=3D<optimized out>) at=20
/usr/include/boost/statechart/custom_reaction.hpp:42
#17 boost::statechart::simple_state<PG::RecoveryState::Reset,=20
PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na=
,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0>::local_react_impl_non_empty::local_=
react_impl<boost::mpl::list5<boost::statechart::custom_reaction<PG::Adv=
Map>,=20
boost::statechart::custom_reaction<PG::ActMap>,=20
boost::statechart::custom_reaction<PG::NullEvt>,=20
boost::statechart::custom_reaction<PG::FlushedEvt>,=20
boost::statechart::transition<boost::statechart::event_base,=20
PG::RecoveryState::Crashed,=20
boost::statechart::detail::no_context<boost::statechart::event_base>,=20
&boost::statechart::detail::no_context<boost::statechart::event_base>::=
no_function>=20
 >, boost::statechart::simple_state<PG::RecoveryState::Reset,=20
PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na=
,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0> > (stt=3D..., evt=3D...,=20
eventType=3DeventType@entry=3D0xcdc260) at=20
/usr/include/boost/statechart/simple_state.hpp:816
#18 0x000000000078ac33 in=20
local_react<boost::mpl::list5<boost::statechart::custom_reaction<PG::Ad=
vMap>,=20
boost::statechart::custom_reaction<PG::ActMap>,=20
boost::statechart::custom_reaction<PG::NullEvt>,=20
boost::statechart::custom_reaction<PG::FlushedEvt>,=20
boost::statechart::transition<boost::statechart::event_base,=20
PG::RecoveryState::Crashed> > > (eventType=3D0xcdc260, evt=3D...,=20
this=3D0x9581270) at /usr/include/boost/statechart/simple_state.hpp:851
#19 boost::statechart::simple_state<PG::RecoveryState::Reset,=20
PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na=
,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0>::local_react_impl_non_empty::local_=
react_impl<boost::mpl::list<boost::statechart::custom_reaction<PG::Quer=
yState>,=20
boost::statechart::custom_reaction<PG::AdvMap>,=20
boost::statechart::custom_reaction<PG::ActMap>,=20
boost::statechart::custom_reaction<PG::NullEvt>,=20
boost::statechart::custom_reaction<PG::FlushedEvt>,=20
boost::statechart::transition<boost::statechart::event_base,=20
PG::RecoveryState::Crashed,=20
boost::statechart::detail::no_context<boost::statechart::event_base>,=20
&boost::statechart::detail::no_context<boost::statechart::event_base>::=
no_function>,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
boost::statechart::simple_state<PG::RecoveryState::Reset,=20
PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na=
,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,=20
mpl_::na, mpl_::na, mpl_::na, mpl_::na>,=20
(boost::statechart::history_mode)0> > (stt=3D..., evt=3D...,=20
eventType=3D0xcdc260) at /usr/include/boost/statechart/simple_state.hpp=
:820
#20 0x000000000076f58b in operator() (this=3D<synthetic pointer>) at=20
/usr/include/boost/statechart/state_machine.hpp:87
#21=20
operator()<boost::statechart::detail::send_function<boost::statechart::=
detail::state_base<std::allocator<void>,=20
boost::statechart::detail::rtti_policy>, boost::statechart::event_base,=
=20
const void*>,=20
boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,=20
PG::RecoveryState::Initial>::exception_event_handler> (action=3D...,=20
this=3D<optimized out>) at=20
/usr/include/boost/statechart/null_exception_translator.hpp:33
#22 boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine=
,=20
PG::RecoveryState::Initial, std::allocator<void>,=20
boost::statechart::null_exception_translator>::send_event=20
(this=3D0xc62fb50, evt=3D...) at=20
/usr/include/boost/statechart/state_machine.hpp:885
#23 0x000000000076f619 in=20
boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,=20
PG::RecoveryState::Initial, std::allocator<void>,=20
boost::statechart::null_exception_translator>::process_event=20
(this=3Dthis@entry=3D0xc62fb50, evt=3D...)
     at /usr/include/boost/statechart/state_machine.hpp:275
#24 0x000000000076f6cd in PG::RecoveryState::handle_event=20
(this=3D0xc62fb50, evt=3D..., rctx=3D0x7f50ddffaa70) at osd/PG.h:1682
#25 0x000000000072bf46 in PG::handle_advance_map (this=3D0xc62e880,=20
osdmap=3Dstd::tr1::shared_ptr (count 83, weak 1) 0x2d59530,=20
lastmap=3Dstd::tr1::shared_ptr (count 59, weak 1) 0x2e85650,=20
newup=3Dstd::vector of length 2, capacity 2 =3D {...},
     newacting=3Dstd::vector of length 3, capacity 4 =3D {...},=20
rctx=3D0x7f50ddffaa70) at osd/PG.cc:5050
#26 0x00000000006cf14b in OSD::advance_pg (this=3Dthis@entry=3D0x2a2764=
0,=20
osd_epoch=3D760, pg=3Dpg@entry=3D0xc62e880, rctx=3Drctx@entry=3D0x7f50d=
dffaa70,=20
new_pgs=3Dnew_pgs@entry=3D0x7f50ddffaa40) at osd/OSD.cc:4042
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#27 0x00000000006cf7f6 in OSD::process_peering_events (this=3D0x2a27640=
,=20
pgs=3Dstd::list) at osd/OSD.cc:6170
Python Exception <type 'exceptions.IndexError'> list index out of range=
:
#28 0x000000000070a3f7 in OSD::PeeringWQ::_process (this=3D<optimized=20
out>, pgs=3Dstd::list) at osd/OSD.h:718
#29 0x00000000008ccccc in ThreadPool::worker (this=3D0x2a27a88,=20
wt=3D0x5cd2cd0) at common/WorkQueue.cc:113
#30 0x00000000008cdc40 in ThreadPool::WorkThread::entry (this=3D<optimi=
zed=20
out>) at common/WorkQueue.h:288
#31 0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
#32 0x000000360d6f167d in clone () from /lib64/libc.so.6


Do you want a full copy of the log file?

It generated 128 MB of logs in those seconds.

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
