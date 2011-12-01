From: Josh Pieper <jjp@pobox.com>
Subject: Re: A couple more ceph-mon crashes
Date: Thu, 1 Dec 2011 07:50:32 -0500
Message-ID: <20111201125032.GF11344@rcn.com>
References: <20111119150309.GA13985@rcn.com>
 <Pine.LNX.4.64.1111211601350.24847@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:51709 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab1LAMue (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Dec 2011 07:50:34 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1111211601350.24847@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Sage,

I've been banging on a recent commit for a while now and haven't been
able to reproduce any of those problems.  Thanks!

-Josh

Sage Weil wrote:
> Hi Josh,
> 
> I just pushed a series of mon patches that rework some of this code.  I've 
> been trashing on them for a while now without problems, though my test 
> still needs to be better about the monitor workload it presents.
> 
> In any case, you should have better luck with the current master.
> 
> Thanks!
> sage
> 
> 
> On Sat, 19 Nov 2011, Josh Pieper wrote:
> 
> > I observed the following two crashes using the same test setup I have
> > had for the previous reports.  3x ubuntu 11.04 amd64 nodes with an rbd
> > load, this time each running cc5b5e17.
> > 
> > Links to the full logs are below each stack trace snip.
> > 
> > mon/OSDMonitor.cc: In function 'MOSDMap* OSDMonitor::build_incremental(epoch_t, epoch_t)', in thread '7fd11a363700'
> > mon/OSDMonitor.cc: 944: FAILED assert(0)
> >  ceph version 0.38-202-gcc5b5e1 (commit:cc5b5e17e64c011b68cc8560676182e187bbb503)
> >  1: (OSDMonitor::build_incremental(unsigned int, unsigned int)+0xc86) [0x497f76]
> >  2: (OSDMonitor::committed()+0x162) [0x49a1f2]
> >  3: (PaxosService::_commit()+0x19e) [0x491fee]
> >  4: (Context::complete(int)+0xa) [0x47c10a]
> >  5: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xca) [0x47da6a]
> >  6: (Paxos::handle_accept(MMonPaxos*)+0x5b4) [0x48dbc4]
> >  7: (Paxos::dispatch(PaxosServiceMessage*)+0x23b) [0x48f38b]
> >  8: (Monitor::_ms_dispatch(Message*)+0xcbf) [0x47b64f]
> >  9: (Monitor::ms_dispatch(Message*)+0x35) [0x486405]
> > 
> > http://joshp.no-ip.com:8080/20111119-mon-build_incremental.log
> > 
> > 
> > mon/PaxosService.cc: In function 'void PaxosService::propose_pending()', in thread '7f4dd6acd700'
> > mon/PaxosService.cc: 127: FAILED assert(have_pending)
> >  ceph version 0.38-202-gcc5b5e1 (commit:cc5b5e17e64c011b68cc8560676182e187bbb503)
> >  1: (PaxosService::propose_pending()+0x335) [0x4924b5]
> >  2: (PGMonitor::check_osd_map(unsigned int)+0xcb0) [0x4d42e0]
> >  3: (Context::complete(int)+0xa) [0x47c10a]
> >  4: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Context*> >&, int)+0xca) [0x47da6a]
> >  5: (Paxos::handle_accept(MMonPaxos*)+0x5d8) [0x48dbe8]
> >  6: (Paxos::dispatch(PaxosServiceMessage*)+0x23b) [0x48f38b]
> >  7: (Monitor::_ms_dispatch(Message*)+0xcbf) [0x47b64f]
> >  8: (Monitor::ms_dispatch(Message*)+0x35) [0x486405]
> > 
> > http://joshp.no-ip.com:8080/20111119-mon-propose_pending.log
> > 
> > -Josh
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
