From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Sat, 19 Jan 2013 10:19:03 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
 <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59473 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3ASSTE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 13:19:04 -0500
In-Reply-To: <50FADE65.5050403@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 19 Jan 2013, Jens Kristian S?gaard wrote:
> Hi Sage,
> 
> > a I dropped the wip branch.  I just repushed the patches (on top of bobtail)
> > for you.
> 
> Thanks for the new build!
> 
> I have finished testing it on one osd - sadly the osd crashed again, but now
> with a new stack trace.
> 
> 0> 2013-01-19 18:48:44.636938 7fb5597f2700 -1 ./osd/OSDMap.h: In function
> 'const epoch_t& OSDMap::get_up_thru(int) const' thread 7fb5597f2700 time
> 2013-01-19 18:48:44.499494
> ./osd/OSDMap.h: 367: FAILED assert(exists(osd))

Do you have a full log for this?

sage

> 
>  ceph version 0.56.1-25-g25a6b1b (25a6b1b325db2a2b45963f83623c447ec577c5ef)
>  1: /usr/bin/ceph-osd() [0x60db42]
>  2: /usr/bin/ceph-osd() [0x6e3b35]
>  3: (pg_interval_t::check_new_interval(std::vector<int, std::allocator<int> >
> const&, std::vector<int, std::allocator<int> > const&, std::vector<int,
> std::allocator<int> > const&, std::vector<int, std::allocator<int> > const&,
> unsigned int, unsigned int, std::tr1::shared_ptr<OSDMap const>,
> std::tr1::shared_ptr<OSDMap const>, long, pg_t, std::map<unsigned int,
> pg_interval_t, std::less<unsigned int>, std::allocator<std::pair<unsigned int
> const, pg_interval_t> > >*, std::ostream*)+0x250) [0x935590]
>  4: (PG::start_peering_interval(std::tr1::shared_ptr<OSDMap const>,
> std::vector<int, std::allocator<int> > const&, std::vector<int,
> std::allocator<int> > const&)+0x353) [0x7563c3]
>  5: (PG::RecoveryState::Reset::react(PG::AdvMap const&)+0x21e) [0x75887e]
>  6: (boost::statechart::detail::reaction_result
> boost::statechart::simple_state<PG::RecoveryState::Reset,
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
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>
> >(boost::statechart::simple_state<PG::RecoveryState::Reset,
> PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>&,
> boost::statechart::event_base const&, void const*)+0x86) [0x78abb6]
>  7: (boost::statechart::detail::reaction_result
> boost::statechart::simple_state<PG::RecoveryState::Reset,
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
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>
> >(boost::statechart::simple_state<PG::RecoveryState::Reset,
> PG::RecoveryState::RecoveryMachine, boost::mpl::list<mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na>, (boost::statechart::history_mode)0>&,
> boost::statechart::event_base const&, void const*)+0x53) [0x78ac33]
>  8: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::send_event(boost::statechart::event_base
> const&)+0x5b) [0x76f58b]
>  9: (boost::statechart::state_machine<PG::RecoveryState::RecoveryMachine,
> PG::RecoveryState::Initial, std::allocator<void>,
> boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
> const&)+0x19) [0x76f619]
>  10: (PG::RecoveryState::handle_event(boost::statechart::event_base const&,
> PG::RecoveryCtx*)+0x4d) [0x76f6cd]
>  11: (PG::handle_advance_map(std::tr1::shared_ptr<OSDMap const>,
> std::tr1::shared_ptr<OSDMap const>, std::vector<int, std::allocator<int> >&,
> std::vector<int, std::allocator<int> >&, PG::RecoveryCtx*)+0x196) [0x72bf46]
>  12: (OSD::advance_pg(unsigned int, PG*, PG::RecoveryCtx*,
> std::set<boost::intrusive_ptr<PG>, std::less<boost::intrusive_ptr<PG> >,
> std::allocator<boost::intrusive_ptr<PG> > >*)+0x48b) [0x6cf14b]
>  13: (OSD::process_peering_events(std::list<PG*, std::allocator<PG*> >
> const&)+0x2a6) [0x6cf7f6]
>  14: (OSD::PeeringWQ::_process(std::list<PG*, std::allocator<PG*> >
> const&)+0x17) [0x70a3f7]
>  15: (ThreadPool::worker(ThreadPool::WorkThread*)+0x95c) [0x8ccccc]
>  16: (ThreadPool::WorkThread::entry()+0x10) [0x8cdc40]
>  17: /lib64/libpthread.so.0() [0x360de07d14]
>  18: (clone()+0x6d) [0x360d6f167d]
> 
> 
> -- 
> Jens Kristian S?gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
