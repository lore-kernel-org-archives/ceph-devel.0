From: Gregory Farnum <greg@inktank.com>
Subject: Re: avoiding false detection of down OSDs
Date: Mon, 30 Jul 2012 17:24:10 -0700
Message-ID: <CAPYLRzhH-MNPHhXbg36jkMGGdh3mtn+jqR5FQDzGta0y67UkPw@mail.gmail.com>
References: <CAPYLRzjoaWkMkz4U+=rZQ+YMS76vkLf_KVZfbWmdLnPuCYadSw@mail.gmail.com>
	<50170EF0.5040004@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38552 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752539Ab2GaAYM convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Jul 2012 20:24:12 -0400
Received: by lahd3 with SMTP id d3so3739846lah.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 17:24:10 -0700 (PDT)
In-Reply-To: <50170EF0.5040004@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 30, 2012 at 3:47 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> I don't understand the functional difference between an OSD that
> is too busy to process its heartbeat in a timely fashion, and
> one that is down.  In either case, it cannot meet its obligations
> to its peers.
>
> I understand that wrongly marking an OSD down adds unnecessary map
> processing work.  Also, if an OSD is wrongly marked down then any
> data that would be written to it while it is marked down will be
> written to other OSDs, and will need to be migrated when that OSD
> is marked back up.
Right. I'm also somewhat uncomfortable with this distinction, but
there is a line that matters: if marking the OSD down and back up is
going to cause more delays than leaving the OSD up, then you don't
want to make any changes. There are specific scenarios we're running
into on systems with many hundreds of nodes where this is a problem.

> I don't fully understand what is the impact of not marking down
> an OSD that really is dead, particularly if the cluster is under
> a heavy write load from many clients.  At the very least, write
> requests that have a replica on such an OSD will stall waiting
> for an ack that will never come, or a new map, right?
Yep, that's precisely the effect.

> It seems to me that each of the discarded solutions has similar
> properties as the favored solution: they address a symptom, rather
> than the cause.
>
> Above you mentioned that you are seeing these issues as you scaled
> out a storage cluster, but none of the solutions you mentioned
> address scaling.  Let's assume your preferred solution handles
> this issue perfectly on the biggest cluster anyone has built
> today.  What do you predict will happen when that cluster size
> is scaled up by a factor of 2, or 10, or 100?
Sage should probably describe in more depth what we've seen since he's
looked at it the most, but I can expand on it a little. In argonaut
and earlier version of Ceph, processing a new OSDMap for an OSD is
very expensive. I don't remember the precise numbers we'd whittled it
down to but it required at least one disk sync as well as pausing all
request processing for a while. If you combined this expense with a
large number of large maps (if, perhaps, one quarter of your 800-OSD
system had been down but not out for 6+ hours), you could cause memory
thrashing on OSDs as they came up, which could force them to become
very, very, veeery slow. In the next version of Ceph, map processing
is much less expensive (no syncs or full-system pauses required),
which will prevent request backup. And there are a huge number of ways
to reduce the memory utilization of maps, some of which can be
backported to argonaut and some of which can't.
Now, if we can't prevent our internal processes from running an OSD
out of memory, we'll have failed. But we don't think this is an
intractable problem; in fact we have reason to hope we've cleared it
up now that we've seen the problem =97 although we don't think it's
something that we can absolutely prevent on argonaut (too much code
churn).
So we're looking for something that we can apply to argonaut as a
band-aid, but that we can also keep around in case forces external to
Ceph start causing similar cluster-scale resource shortages beyond our
control (runaway co-located process eats up all the memory on lots of
boxes, switch fails and bandwidth gets cut in half, etc). If something
happens that means Ceph can only supply half as much throughput as it
was previously, then Ceph should provide that much throughput; right
now if that kind of incident occurs then Ceph won't provide any
throughput because it'll all be eaten by spurious recovery work.

>> This algorithm has several nice properties:
>> 1) It allows us to independently account for both the probability th=
at
>> the node is laggy, and for the length of time the node is usually
>> laggy for.
>
> This implies to me you think the root cause of lagginess is
> independent of client offered load.  Otherwise, if client offered
> load does impact lagginess, then your estimate of the probability
> that an OSD is laggy is only useful for as long as your offered load
> doesn't change, no?
Approximately =97 client requests are throttled at ingress; all the
issues we've seen are caused by internal traffic.


>> 2) It localizes lagginess by PG relationships =97 if your Ceph clust=
er
>> has multiple pools stored in different locations, lagginess won't
>> cross those boundaries.
>> 3) It's not too expensive, and by framing it the way we have (in ter=
ms
>> of estimating probabilities) we can shuffle the generic algorithm
>> around (eg, eventually move these calculations to the reporting OSDs=
).
>> There are a couple of things it doesn't do:
>> 1) It doesn't do a good job of noticing that a particular rack is
>> laggy compared to other racks within the same pool.
>> 2) It's all continuous =97 there isn't yet any sense of "don't guess
>> anybody is laggy until we've seen a certain amount of churn over the
>> last x minutes".
>>
>> We think that this is a good start and that any necessary
>> modifications will be pretty easy to add, but if you have other idea=
s
>> or critiques we'd love to hear about them!
>
>
> As I mentioned above, I'm concerned this is addressing
> symptoms, rather than root causes.  I'm concerned the
> root cause has something to do with how the map processing
> work scales with number of OSDs/PGs, and that this will
> limit the maximum size of a Ceph storage cluster.
I think I discussed this above enough already? :)


> But, if you really just want to not mark down an OSD that is
> laggy, I know this will sound simplistic, but I keep thinking
> that the OSD knows for itself if it's up, even when the
> heartbeat mechanism is backed up.  Couldn't there be some way
> to ask an OSD suspected of being down whether it is or not,
> separate from the heartbeat mechanism?  I mean, if you're
> considering having the monitor ignore OSD down reports for a
> while based on some estimate of past behavior, wouldn't it be
> better for the monitor to just ask such an OSD, "hey, are you
> still there?"  If it gets an immediate "I'm busy, come back later",
> extend the grace period; otherwise, mark the OSD down.
Hmm. The concern is that if an OSD is stuck on disk swapping then it's
going to be just as stuck for the monitors as the OSDs =97 they're all
using the same network in the basic case, etc. We want to be able to
make that guess before the OSD is able to answer such questions.
But I'll think on if we could try something else similar.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
