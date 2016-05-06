From: Sage Weil <sweil@redhat.com>
Subject: Re: on-the-wire encryption, addrs, and cephx
Date: Fri, 6 May 2016 08:29:10 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605060823190.15518@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com> <CAJ4mKGaU_oB6QLGxUF5irPM4T9FOoN0Q=wRNWBXH0TS0GFMEQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757910AbcEFM3B (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 6 May 2016 08:29:01 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D925A15558
	for <ceph-devel@vger.kernel.org>; Fri,  6 May 2016 12:29:00 +0000 (UTC)
In-Reply-To: <CAJ4mKGaU_oB6QLGxUF5irPM4T9FOoN0Q=wRNWBXH0TS0GFMEQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 5 May 2016, Gregory Farnum wrote:
> > There are a few questions:
> >
> > - Should we bother implementing v2 for SimpleMessenger?  I think no.
> 
> I think we have to implement this for SimpleMessenger. I know we want
> to move to AsyncMessenger ASAP, but until we've resolved any top-line
> performance issues it won't be appropriate to deprecate the
> SimpleMessenger.
> 
> And unless we really are doing a whole new wire protocol that doesn't
> need to be in any way compatible with other implementations (like,
> say, the kernel clients), it'll make us a lot more confident that it
> is appropriately backwards-compatible and works correctly to have the
> AsyncMessenger and SimpleMessenger speaking it to each other.

Well, it won't be compatible at all--that's why the wip-addr and mon port 
change are part of the plan.

We'll need to keep SimpleMessenger around for along time, and we'll also 
need to keep the v1 protocol support around for a long time (probably a 
couple years at least) for the benefit of old clients.  And there's no 
reason anybody *has* to switch to the new protocol unless they need the 
new features or improved security.  If someone can't move to msg/async for 
stability/performance reasons, they can just keep using SimpleMessenger 
until they get resolved--that has to happen in the next cycle or two (vs 
the years before we remove the old code).

sage
