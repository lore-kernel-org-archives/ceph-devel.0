From: Sage Weil <sage@newdream.net>
Subject: Re: proposal : read/write threads and handles separation in civetweb
 and rgw
Date: Tue, 11 Jul 2017 13:22:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707111321400.3424@piezo.novalocal>
References: <CAP3mxSxpaAoVFsNusx9E6eudVtK_hYcN7HcwuCr27YcoHrPsaw@mail.gmail.com> <CAKOnarkBg16Cxxa2eTFbMT8K_BMqPbsnoJhjDyfzWxen-boYow@mail.gmail.com> <CAKOnarn0y5K0MERaxh7NCDFjvUQZ1V3CP6JSVLuN5uu3GM+O-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46594 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdGKNWM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 09:22:12 -0400
In-Reply-To: <CAKOnarn0y5K0MERaxh7NCDFjvUQZ1V3CP6JSVLuN5uu3GM+O-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 11 Jul 2017, Matt Benjamin wrote:
> Hi Abhishek,
> 
> There are plans in place to provide for enhanced scheduling and
> fairness intrinsically, somewhat in tandem with new front-end
> (boost::asio/beast) and librados interfacing work by Adam.  I'm not
> clear whether this proposal advances that goal, or not.  It seems like
> it adds complexity that we won't want to retain for the long term, but
> maybe it's helpful in ways I don't understand yet.
> 
> It seems like it would definitely make sense to have a focused
> discussion in one of our standups of the broader issues, approaches
> being taken, and so on.

The (currently empty) agenda for the next CDM (Aug 2) is here:

	http://tracker.ceph.com/projects/ceph/wiki/CDM_02-AUG-2017?parent=Planning

sage

> regards,
> 
> Matt
> 
> On Mon, Jul 10, 2017 at 8:01 AM, Matt Benjamin <mbenjami@redhat.com> wrote:
> > Hi Abhishek,
> >
> > There are plans in place to provide for enhanced scheduling and fairness
> > intrinsically, somewhat in tandem with new front-end (boost::asio/beast) and
> > librados interfacing work by Adam.  I'm not clear whether this proposal
> > advances that goal, or not.  It seems like it adds complexity that we won't
> > want to retain for the long term, but maybe it's helpful in ways I don't
> > understand yet.
> >
> > It seems like it would definitely make sense to have a focused discussion in
> > one of our standups of the broader issues, approaches being taken, and so
> > on.
> >
> > regards,
> >
> > Matt
> >
> >
> > On Mon, Jul 10, 2017 at 7:47 AM, Abhishek Varshney
> > <abhishek.varshney@flipkart.com> wrote:
> >>
> >> TL;DR
> >> ---------
> >> The proposal is to separate out read and write threads/handles in
> >> civetweb/rgw to reduce the blast radius in case of an outage caused
> >> due to one type of op (GET or PUT) being blocked or latent. Proposal
> >> PR : https://github.com/ceph/civetweb/pull/21
> >>
> >> Problem Statment
> >> ------------------------
> >> Our production clusters, primarily running object gateway workloads on
> >> hammer, have quite a few times seen one type of op (GET or PUT) being
> >> blocked or latent due to different reasons. This have resulted in a
> >> complete outage with rgw becoming totally un-responsive and unable to
> >> accept connections. After root causing the issue, it is found that
> >> there is no separation of resources, threads and handles at civetweb
> >> and rgw layers, which causes a complete blackout.
> >>
> >> Scenarios
> >> --------------
> >> Some scenarios which are known to block one kind of op (GET or PUT).
> >>
> >> * PUTs are blocked when pool with bucket index is degraded. We have
> >> large omap objects, recovery/rebalancing of which is known to block
> >> PUT ops for longer duration of times ( ~ couple of hours). We are
> >> working to address this issue separately also.
> >>
> >> * GETs are blocked when rgw data pool (which is front-ended by a
> >> writeback cache tier on a different crush root) is degraded.
> >>
> >> There could be other such scenarios too.
> >>
> >> Proposed Approach
> >> ---------------------------
> >> The proposal here is to separate read and write resources in terms of
> >> threads in civetweb and rados handles in rgw which would help to limit
> >> the blast radius and reduce the impact of any outage that may happen.
> >>
> >> * civetweb : currently in civetweb, there is a common pool of worker
> >> threads which consume sockets from a queue to process. In case of
> >> blocked requests in ceph, the queue becomes full and civetweb master
> >> thread is stuck in a loop waiting for the queue to become empty [1]
> >> and is unable to process any more requests.
> >>
> >> The proposal is to introduce 2 additional queues, a read connection
> >> queue and a write connection queue along with a dispatcher thread
> >> which picks sockets from the socket queue and puts them to one of
> >> these queues based on the type of the op. In case, a queue is full,
> >> the dispatcher thread would return a 503 instead of waiting for that
> >> queue to be empty again.
> >>
> >> This is supposed to limit failures and thus improve the availability
> >> of the clusters.
> >>
> >> The ideas described above are presented in the form of a PR here :
> >> https://github.com/ceph/civetweb/pull/21
> >>
> >> * rgw : while the proposed changes in civetweb should give major
> >> returns, next level of optimisations can be done in rgw, where the
> >> rados handles can be separated again based on the type of op, so that
> >> civetweb worker threads dont end up contending on rados handles.
> >>
> >> Would love to hear suggestions, opinions and feedback from the community.
> >>
> >> PS : Due to lack of a proper branch which keeps track of latest branch
> >> of civetweb and as per the suggestions received from the irc channel,
> >> the PR is raised against wip-listen4 branch of civetweb.
> >>
> >> 1. https://github.com/ceph/civetweb/blob/wip-listen4/src/civetweb.c#L12558
> >>
> >> Thanks
> >> Abhishek Varshney
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
