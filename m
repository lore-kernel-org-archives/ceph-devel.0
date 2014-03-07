From: Gregory Farnum <greg@inktank.com>
Subject: Re: contraining crush placement possibilities
Date: Fri, 7 Mar 2014 10:00:13 -0800
Message-ID: <CAPYLRziXip2hTtU+MW6whJ+hryPJqeMxb-wbf7XF+fdiaf8nkA@mail.gmail.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
	<CABZ+qqkYw2CznTS5ters9LMaX7zPMQ8LxvB8e0rfGuz_3BYXZA@mail.gmail.com>
	<alpine.DEB.2.00.1403070705440.24219@cobra.newdream.net>
	<CAPYLRziGh52rUq1yk5U74D55zs+C=Sda9Dm_UbR9M7F5sECSdA@mail.gmail.com>
	<alpine.DEB.2.00.1403070934450.3593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:46209 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbaCGSAO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Mar 2014 13:00:14 -0500
Received: by mail-qa0-f43.google.com with SMTP id j15so4340948qaq.2
        for <ceph-devel@vger.kernel.org>; Fri, 07 Mar 2014 10:00:13 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1403070934450.3593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Mar 7, 2014 at 9:43 AM, Sage Weil <sage@inktank.com> wrote:
> On Fri, 7 Mar 2014, Gregory Farnum wrote:
>> On Fri, Mar 7, 2014 at 7:10 AM, Sage Weil <sage@inktank.com> wrote:
>> > On Fri, 7 Mar 2014, Dan van der Ster wrote:
>> >> On Thu, Mar 6, 2014 at 9:30 PM, Sage Weil <sage@inktank.com> wrote:
>> >> > Sheldon just
>> >> > pointed out a talk from ATC that discusses the basic problem:
>> >> >
>> >> >         https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon
>> >> >
>> >> > The situation with CRUSH is slightly better, I think, because the number
>> >> > of peers for a given OSD in a large cluster is bounded (pg_num /
>> >> > num_osds), but I think we may still be able improve things.
>> >>
>> >> I'm surprised they didn't cite Ceph -- aren't copysets ~= placement groups?
>> >
>> > I think so (I didn't listen to the whole talk :).  My ears did perk up
>> > when Carlos (who was part of the original team at UCSC) asked the question
>> > about the CRUSH paper at the end, though. :)
>> >
>> > Anyway, now I'm thinking that this *is* really just all about tuning
>> > pg_num/pgp_num.  And of course managing failure domains in the CRUSH map
>> > as best we can to align placement with expected sources of correlated
>> > failure.  But again, I would appreciate any confirmation from others'
>> > intuitions or (better yet) a proper mathematical model.  This bit of my
>> > brain is full of cobwebs, and wasn't particularly strong here to begin
>> > with.
>>
>> Well, yes and no. They're constraining data sharing in order to reduce
>> the probability of any given data loss event, and we can reduce data
>> sharing by reducing the pgp_num. But the example you cited was "place
>> all copies in the top third of the selected racks", and that's a
>> little different because it means they can independently scale the
>> data sharing *within* that grouping to maintain a good data balance,
>> which CRUSH would have trouble with.
>> Unfortunately my intuition around probability and stats isn't much
>> good, so that's about as far as I can take this effectively. ;)
>
> Yeah I'm struggling with this too, but I *think* the top/middle/bottom
> rack analogy is just an easy way to think about constraining the placement
> options, which we're doing anyway with the placement group count--just in
> a way that looks random but is still sampling a small portion of the
> possible combinations.  In the end, whether you eliminate 8/9 of the
> options of the rack layers and *then* scale pg_num, or just scale pg_num,
> I think it still boils down to the number of distinct 3-disk sets out of
> the total possible 3-disk sets.

Mmm, the bounds are very different in those two environments, though.
Let's say you have 3 racks of 9 OSDs; with CRUSH splitting across
racks you have 9^3=729 possible combinations of placement; with
thirded racks you have 3*(3^3)=81. If you constrain CRUSH to 81 PGs,
you're going to have a terrible distribution. But with a different
system it's easy to scale your shards within each grouping to maintain
balance within each group, and to adjust the boundaries between groups
as well.

>
> Also, FWIW, the rack thing is equivalent to making 3 parallel trees so
> that the crush hierarchy goes like:
>
>  root
>  layer of rack (top/middle/bottom)
>  rack
>  host
>  osd
>
> and make the crush rule first pick 1 layer before doing the chooseleaf
> over racks.

That I missed -- I was thinking we didn't have a good way to do the
split in CRUSH, but I guess if you're doing same-rack-pos then just
doing the split at the top you could probably emulate the system above
reasonably well...maybe? We should run some experiments with the crush
tester and figure out if we can get a reasonable data distribution
with reasonable PG counts under a schema like that.
-Greg
