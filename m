From: Sage Weil <sage@inktank.com>
Subject: Re: Pre-creating pools for radosgw
Date: Tue, 14 Aug 2012 11:16:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208141115550.18862@cobra.newdream.net>
References: <CAMmJxt+JsGEU_oxJSKv-=4ofVWGfHyU4rNnPMavjmJj+SqCLag@mail.gmail.com> <alpine.DEB.2.00.1208141056130.18862@cobra.newdream.net> <CAMmJxt+PjdCLEQ=2SjoPn8cp58tKw4CdF=aBxfKKq058-+tRzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55875 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab2HNSQJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 14:16:09 -0400
In-Reply-To: <CAMmJxt+PjdCLEQ=2SjoPn8cp58tKw4CdF=aBxfKKq058-+tRzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Tue, 14 Aug 2012, John Axel Eriksson wrote:
> I guess I could use either:
> 
> ceph osd pool create .rgw.buckets 1024 1024
> 
> OR
> 
> ceph osd pool create .rgw.buckets 1024
> (where pgp_num would default to 1024)
> 
> right?

Yep!

> 
> Thanks alot for your input!

No problem.

sage


> 
> On Tue, Aug 14, 2012 at 7:59 PM, Sage Weil <sage@inktank.com> wrote:
> > On Tue, 14 Aug 2012, John Axel Eriksson wrote:
> >> Hi,
> >>
> >> Since we setup a test cluster, only for use with radosgw, we've
> >> noticed that pg_num is set to 8 for all the pools rgw uses. Our
> >> test-cluster only has two OSDs but when we go live we plan on having a
> >> few more of them. We anticipate going to maybe 10 OSDs in 6 months
> >> time.
> >> There's been talk on this list about this before and there have been
> >> some solutions... I'd like to properly set it up before we go live
> >> though and I've come to understand that it's not something you easily
> >> change after data has been stored to the cluster (through rgw). I've
> >> checked the existing pools and as I said, the rgw ones are all set to
> >> 8 pgs. I assume ALL pools starting with "." are created by rgw even
> >> though not all of them are called .rgw.<something> (such as .log,
> >> .intent-log, .users.email etc). Anyway, some of them could probably
> >> stay at 8 pgs I guess. I did a pretty quick calculation and came up
> >> with something like this:
> >>
> >> .rgw.buckets = 1024
> >> .log = 84
> >> .rgw: 52
> >> .rgw.control: 8 # eg. default value
> >> .users.uid: 32
> >> .users.email: 32
> >> .users: 8 # eg. default value
> >> .usage: 8 # eg. default value
> >> .intent-log: 32
> >>
> >> this totals to 1280. Afaik a power of two is slightly more performant.
> >> The other pools - data, metadata and rbd won't be used by us - they're
> >> all set to 256 by default. Adding that we end up with 2048 pools.
> >> Would this be a reasonable value?
> >
> > For 10 OSDs, yes.
> >
> >> Also can we perhaps delete the data, metadata and rbd pools if we're
> >> only using rgw?
> >
> > Yes.
> >
> >> We plan on having 2 copies (the default I think) of everything in the
> >> cluster but may go to 3 - not sure.
> >>
> >> How would I pre-create the pools by the way? I assume you would go
> >> about it like this:
> >>
> >> rados mkpool .rgw.buckets
> >> ceph osd pool set .rgw.buckets pg_num 1024
> >
> > ceph osd pool create .rgw.buckets 1024
> >
> >>
> >> etc
> >>
> >> All of that BEFORE ever starting/using RadosGW. I wouldn't have to
> >> create the pools with default values I guess. Am I correct in my
> >> assumptions?
> >>
> >> Also what do these mean (from docs):
> >>
> >> pg_num: See above.
> >> pgp_num: See above.
> >> lpg_num: The number of local PGs.
> >> lpgp_num: The number used for placing the local PGs.
> >
> > l* values are deprecated.
> >
> > pgp_num lets you have a larger number of PGs but place/distribute them as
> > if there were a smaller number.  It is part of the legacy split process,
> > but may not be needed for the new implementation.  You can ignore them
> > all; just worry about pg_num (pgp_num will match that).
> >
> >>
> >> Should I set any of these?
> >>
> >>
> >> I assume changing the number of replicas would be done like this:
> >>
> >> ceph osd pool set .rgw.buckets size 3 # for 3 replicas
> >>
> >> Above can be done after data has been stored through rgw, right?
> >
> > Right.
> >
> >> I also assume that the actual data stored via radosgw is stored in
> >> .rgw.buckets. I know you're planning on adding pg-splitting but I'd
> >> like to do this well before that is released.
> >>
> >> So, could you please just confirm or correct what I assume?
> >
> > Looks like you're on the right track.
> >
> > sage
> >
> >>
> >> Thanks alot!
> >>
> >> John
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> 
> 
