From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Sun, 20 Jan 2013 16:14:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
 <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43161 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab3AUAOB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Jan 2013 19:14:01 -0500
In-Reply-To: <50FAE8AB.5000602@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The secondary crash is fixed by 17160843d0c523359d8fa934418ff2c1f7bffb25.
Also backported to bobtail.

If you have the core from the second instance of the heartbeat timeout, 
from the wip-pg-removal branch, please post the 'thread apply all bt' 
output.

Thanks!
sage



On Sat, 19 Jan 2013, Jens Kristian S?gaard wrote:

> Hi Sage,
> 
> > Do you have a full log for this?
> 
> I upped the log level and started the osd again.
> 
> It ran for 23 seconds and then suddenly crashed out of the blue.
> 
> The last log lines were:
> 
> 2013-01-19 19:31:39.975475 7f50de7fc700 10 osd.2 pg_epoch: 416 pg[0.fc( v
> 164'38593 (164'37592,164'38593] local-les=247 n=2622 ec=1 les/c 247/156
> 379/379/379) [1,3] r=-1 lpr=379 pi=152-378/14 lcod 0'0 inactive NOTIFY]
> state<Reset>: Reset advmap
> 2013-01-19 19:31:39.975483 7f50de7fc700 10 osd.2 pg_epoch: 416 pg[0.fc( v
> 164'38593 (164'37592,164'38593] local-les=247 n=2622 ec=1 les/c 247/156
> 379/379/379) [1,3] r=-1 lpr=379 pi=152-378/14 lcod 0'0 inactive NOTIFY]
> _calc_past_interval_range: already have past intervals back to 156
> 2013-01-19 19:31:39.975495 7f50de7fc700 10 osd.2 pg_epoch: 416 pg[0.fc( v
> 164'38593 (164'37592,164'38593] local-les=247 n=2622 ec=1 les/c 247/156
> 379/379/379) [1,3] r=-1 lpr=379 pi=152-378/14 lcod 0'0 inactive NOTIFY]
> handle_advance_map [1,3]/[1,3]
> 2013-01-19 19:31:39.975505 7f50de7fc700 10 osd.2 pg_epoch: 417 pg[0.fc( v
> 164'38593 (164'37592,164'38593] local-les=247 n=2622 ec=1 les/c 247/156
> 379/379/379) [1,3] r=-1 lpr=379 pi=152-378/14 lcod 0'0 inactive NOTIFY]
> state<Reset>: Reset advmap
> 2013-01-19 19:31:39.975513 7f50de7fc700 10
> 
> 
> The stack trace from the core file shows:
> 
> Program terminated with signal 6, Aborted.
> #0  0x000000360de0eebb in raise () from /lib64/libpthread.so.0
> Missing separate debuginfos, use: debuginfo-install
> boost-thread-1.48.0-13.fc17.x86_64 glibc-2.15-57.fc17.x86_64
> libaio-0.3.109-5.fc17.x86_64 libgcc-4.7.2-2.fc17.x86_64
> libstdc++-4.7.2-2.fc17.x86_64 libuuid-2.21.2-2.fc17.x86_64
> nspr-4.9.2-1.fc17.x86_64 nss-3.13.5-1.fc17.x86_64
> nss-softokn-3.13.5-1.fc17.x86_64 nss-softokn-freebl-3.13.5-1.fc17.x86_64
> nss-util-3.13.5-1.fc17.x86_64 sqlite-3.7.11-3.fc17.x86_64
> (gdb) bt
> #0  0x000000360de0eebb in raise () from /lib64/libpthread.so.0
> #1  0x000000000082f7a6 in reraise_fatal (signum=6) at
> global/signal_handler.cc:58
> #2  handle_fatal_signal (signum=6) at global/signal_handler.cc:104
> #3  <signal handler called>
> #4  0x000000360d635925 in raise () from /lib64/libc.so.6
> #5  0x000000360d6370d8 in abort () from /lib64/libc.so.6
> #6  0x0000003611660dad in __gnu_cxx::__verbose_terminate_handler() () from
> /lib64/libstdc++.so.6
> #7  0x000000361165eea6 in ?? () from /lib64/libstdc++.so.6
> #8  0x000000361165eed3 in std::terminate() () from /lib64/libstdc++.so.6
> #9  0x000000361165f0fe in __cxa_throw () from /lib64/libstdc++.so.6
> #10 0x00000000008d5edd in ceph::__ceph_assert_fail (assertion=0x99b1b8
> "exists(osd)", file=<optimized out>, line=367, func=0x99fa20 "const epoch_t&
> OSDMap::get_up_thru(int) const") at common/assert.cc:77
> #11 0x000000000060db42 in OSDMap::get_up_thru (osd=<optimized out>,
> this=<optimized out>) at osd/OSDMap.h:367
> #12 0x00000000006e3b35 in OSDMap::get_up_thru (this=<optimized out>,
> osd=<optimized out>) at osd/OSDMap.h:369
> #13 0x0000000000935590 in pg_interval_t::check_new_interval (old_acting=...,
> new_acting=..., old_up=..., new_up=..., same_interval_since=553,
> last_epoch_clean=425, osdmap=std::tr1::shared_ptr (count 83, weak 1)
> 0x2d59530,
>     lastmap=std::tr1::shared_ptr (count 59, weak 1) 0x2e85650, pool_id=0,
> pgid=..., past_intervals=0xc62ef78, out=0x0) at osd/osd_types.cc:1537
> #14 0x00000000007563c3 in PG::start_peering_interval
> (this=this@entry=0xc62e880, lastmap=std::tr1::shared_ptr (count 59, weak 1)
> 0x2e85650, newup=std::vector of length 2, capacity 2 = {...},
> newacting=std::vector of length 3, capacity 3 = {...}) at osd/PG.cc:4624
> #15 0x000000000075887e in PG::RecoveryState::Reset::react
> (this=this@entry=0x9581270, advmap=...) at osd/PG.cc:5241
> #16 0x000000000078abb6 in react<PG::RecoveryState::Reset,
> boost::statechart::event_base, void const*> (evt=..., stt=...,
> eventType=<optimized out>) at
> /usr/include/boost/statechart/custom_reaction.hpp:42
> #17 boost::statechart::simple_state<PG::RecoveryState::Reset,
> PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> (boost::statechart::history_mode)0>::local_react_impl_non_empty::local_react_impl<boost::mpl::list5<boost::statechart::custom_reaction<PG::AdvMap>,
> boost::statechart::custom_reaction<PG::ActMap>,
> boost::statechart::custom_reaction<PG::NullEvt>,
> boost::statechart::custom_reaction<PG::FlushedEvt>,
> boost::statechart::transition<boost::statechart::event_base,
> PG::RecoveryState::Crashed,
> boost::statechart::detail::no_context<boost::statechart::event_base>,
> &boost::statechart::detail::no_context<boost::statechart::event_base>::no_function>
> >, boost::statechart::simple_state<PG::RecoveryState::Reset,
> PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0> >
> (stt=..., evt=..., eventType=eventType@entry=0xcdc260) at
> /usr/include/boost/statechart/simple_state.hpp:816
> #18 0x000000000078ac33 in
> local_react<boost::mpl::list5<boost::statechart::custom_reaction<PG::AdvMap>,
> boost::statechart::custom_reaction<PG::ActMap>,
> boost::statechart::custom_reaction<PG::NullEvt>,
> boost::statechart::custom_reaction<PG::FlushedEvt>,
> boost::statechart::transition<boost::statechart::event_base,
> PG::RecoveryState::Crashed> > > (eventType=0xcdc260, evt=..., this=0x9581270)
> at /usr/include/boost/statechart/simple_state.hpp:851
> #19 boost::statechart::simple_state<PG::RecoveryState::Reset,
> PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> (boost::statechart::history_mode)0>::local_react_impl_non_empty::local_react_impl<boost::mpl::list<boost::statechart::custom_reaction<PG::QueryState>,
> boost::statechart::custom_reaction<PG::AdvMap>,
> boost::statechart::custom_reaction<PG::ActMap>,
> boost::statechart::custom_reaction<PG::NullEvt>,
> boost::statechart::custom_reaction<PG::FlushedEvt>,
> boost::statechart::transition<boost::statechart::event_base,
> PG::RecoveryState::Crashed,
> boost::statechart::detail::no_context<boost::statechart::event_base>,
> &boost::statechart::detail::no_context<boost::statechart::event_base>::no_function>,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na>,
> boost::statechart::simple_state<PG::RecoveryState::Reset,
> PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0> >
> (stt=..., evt=..., eventType=0xcdc260) at
> /usr/include/boost/statechart/simple_state.hpp:820
> #20 0x000000000076f58b in operator() (this=<synthetic pointer>) at
> /usr/include/boost/statechart/state_machine.hpp:87
> #21
> operator()<boost::statechart::detail::send_function<boost::statechart::detail::state_base<std::allocator<void>,
> boost::statechart::detail::rtti_policy>, boost::statechart::event_base, const
> void*>, boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial>::exception_event_handler> (action=...,
> this=<optimized out>) at
> /usr/include/boost/statechart/null_exception_translator.hpp:33
> #22 boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::send_event (this=0xc62fb50,
> evt=...) at /usr/include/boost/statechart/state_machine.hpp:885
> #23 0x000000000076f619 in
> boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::process_event
> (this=this@entry=0xc62fb50, evt=...)
>     at /usr/include/boost/statechart/state_machine.hpp:275
> #24 0x000000000076f6cd in PG::RecoveryState::handle_event (this=0xc62fb50,
> evt=..., rctx=0x7f50ddffaa70) at osd/PG.h:1682
> #25 0x000000000072bf46 in PG::handle_advance_map (this=0xc62e880,
> osdmap=std::tr1::shared_ptr (count 83, weak 1) 0x2d59530,
> lastmap=std::tr1::shared_ptr (count 59, weak 1) 0x2e85650, newup=std::vector
> of length 2, capacity 2 = {...},
>     newacting=std::vector of length 3, capacity 4 = {...},
> rctx=0x7f50ddffaa70) at osd/PG.cc:5050
> #26 0x00000000006cf14b in OSD::advance_pg (this=this@entry=0x2a27640,
> osd_epoch=760, pg=pg@entry=0xc62e880, rctx=rctx@entry=0x7f50ddffaa70,
> new_pgs=new_pgs@entry=0x7f50ddffaa40) at osd/OSD.cc:4042
> Python Exception <type 'exceptions.IndexError'> list index out of range:
> #27 0x00000000006cf7f6 in OSD::process_peering_events (this=0x2a27640,
> pgs=std::list) at osd/OSD.cc:6170
> Python Exception <type 'exceptions.IndexError'> list index out of range:
> #28 0x000000000070a3f7 in OSD::PeeringWQ::_process (this=<optimized out>,
> pgs=std::list) at osd/OSD.h:718
> #29 0x00000000008ccccc in ThreadPool::worker (this=0x2a27a88, wt=0x5cd2cd0) at
> common/WorkQueue.cc:113
> #30 0x00000000008cdc40 in ThreadPool::WorkThread::entry (this=<optimized out>)
> at common/WorkQueue.h:288
> #31 0x000000360de07d14 in start_thread () from /lib64/libpthread.so.0
> #32 0x000000360d6f167d in clone () from /lib64/libc.so.6
> 
> 
> Do you want a full copy of the log file?
> 
> It generated 128 MB of logs in those seconds.
> 
> -- 
> Jens Kristian S?gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> 
> 
