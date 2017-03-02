From: Sage Weil <sweil@redhat.com>
Subject: Re: explicitly mapping pgs in OSDMap
Date: Thu, 2 Mar 2017 06:17:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703020614310.651@piezo.novalocal>
References: <alpine.DEB.2.11.1703011932530.651@piezo.novalocal> <CABPQP67RrSL6-naFj2MvJKcPRbCWkJDbWaRyN9rGdojiXcD0Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754159AbdCBILQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Mar 2017 03:11:16 -0500
In-Reply-To: <CABPQP67RrSL6-naFj2MvJKcPRbCWkJDbWaRyN9rGdojiXcD0Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthew Sedam <sedammatthew@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 1 Mar 2017, Matthew Sedam wrote:
> Sage,
> 
> Hi! I am a potential GSOC 2017 student, and I am interested in the
> Ceph-mgr: Smarter Reweight_by_Utilization project. However, when
> reading this I wondered if this proposed idea would make my GSOC
> project effectively null and void. Could you elaborate on this?

I would consider the below an evolution of the role of 
reweight-by-utilization.  The complexity in improving the approach is less 
around what the mechanism is that it uses to make the adjustment, and more 
around reasoning about how the current utilization is assigned to PGs, how 
PG sizes are estimated, and so on.  The problem is pretty straightforward 
when you have a uniform CRUSH hierarchy and all data is spread across 
the cluster; when you have different CRUSH rules that distributed to only 
some devices, especially when those devices overlap, things get tricky.

In any case, this just makes the project more interesting, with several 
possible avenues for improvement and optimization.  :)

sage



 > 
> Matthew Sedam
> 
> On Wed, Mar 1, 2017 at 1:44 PM, Sage Weil <sweil@redhat.com> wrote:
> > There's been a longstanding desire to improve the balance of PGs and data
> > across OSDs to better utilize storage and balance workload.  We had a few
> > ideas about this in a meeting last week and I wrote up a summary/proposal
> > here:
> >
> >         http://pad.ceph.com/p/osdmap-explicit-mapping
> >
> > The basic idea is to have the ability to explicitly map individual PGs
> > to certain OSDs so that we can move PGs from overfull to underfull
> > devices.  The idea is that the mon or mgr would do this based on some
> > heuristics or policy and should result in a better distribution than teh
> > current osd weight adjustments we make now with reweight-by-utilization.
> >
> > The other key property is that one reason why we need as many PGs as we do
> > now is to get a good balance; if we can remap some of them explicitly, we
> > can get a better balance with fewer.  In essense, CRUSH gives an
> > approximate distribution, and then we correct to make it perfect (or close
> > to it).
> >
> > The main challenge is less about figuring out when/how to remap PGs to
> > correct balance, but figuring out when to remove those remappings after
> > CRUSH map changes.  Some simple greedy strategies are obvious starting
> > points (e.g., to move PGs off OSD X, first adjust or remove existing remap
> > entries targetting OSD X before adding new ones), but there are a few
> > ways we could structure the remap entries themselves so that they
> > more gracefully disappear after a change.
> >
> > For example, a remap entry might move a PG from OSD A to B if it maps to
> > A; if the CRUSH topology changes and the PG no longer maps to A, the entry
> > would be removed or ignored.  There are a few ways to do this in the pad;
> > I'm sure there are other options.
> >
> > I put this on the agenda for CDM tonight.  If anyone has any other ideas
> > about this we'd love to hear them!
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
