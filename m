From: Sage Weil <sage@inktank.com>
Subject: Re: contraining crush placement possibilities
Date: Fri, 7 Mar 2014 07:10:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403070705440.24219@cobra.newdream.net>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net> <CABZ+qqkYw2CznTS5ters9LMaX7zPMQ8LxvB8e0rfGuz_3BYXZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42571 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbaCGPKC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Mar 2014 10:10:02 -0500
In-Reply-To: <CABZ+qqkYw2CznTS5ters9LMaX7zPMQ8LxvB8e0rfGuz_3BYXZA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 7 Mar 2014, Dan van der Ster wrote:
> On Thu, Mar 6, 2014 at 9:30 PM, Sage Weil <sage@inktank.com> wrote:
> > Sheldon just
> > pointed out a talk from ATC that discusses the basic problem:
> >
> >         https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon
> >
> > The situation with CRUSH is slightly better, I think, because the number
> > of peers for a given OSD in a large cluster is bounded (pg_num /
> > num_osds), but I think we may still be able improve things.
> 
> I'm surprised they didn't cite Ceph -- aren't copysets ~= placement groups?

I think so (I didn't listen to the whole talk :).  My ears did perk up 
when Carlos (who was part of the original team at UCSC) asked the question 
about the CRUSH paper at the end, though. :)

Anyway, now I'm thinking that this *is* really just all about tuning 
pg_num/pgp_num.  And of course managing failure domains in the CRUSH map 
as best we can to align placement with expected sources of correlated 
failure.  But again, I would appreciate any confirmation from others' 
intuitions or (better yet) a proper mathematical model.  This bit of my 
brain is full of cobwebs, and wasn't particularly strong here to begin 
with.

sage
