From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: global backfill reservation?
Date: Mon, 15 May 2017 15:02:51 -0700
Message-ID: <CAJ4mKGag26AdYAOU_A96tRKvSqjNt2NpA2nbeZN+xBXL+rw-iQ@mail.gmail.com>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal> <99194e05-6bb9-29db-a85b-bf13da36fcf4@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34427 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdEOWCx (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 May 2017 18:02:53 -0400
Received: by mail-io0-f180.google.com with SMTP id k91so82652750ioi.1
        for <ceph-devel@vger.kernel.org>; Mon, 15 May 2017 15:02:52 -0700 (PDT)
In-Reply-To: <99194e05-6bb9-29db-a85b-bf13da36fcf4@brockmann-consult.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maloney <peter.maloney@brockmann-consult.de>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 12, 2017 at 1:49 PM, Peter Maloney
<peter.maloney@brockmann-consult.de> wrote:
> On 05/12/17 20:53, Sage Weil wrote:
>> A common complaint is that recovery/backfill/rebalancing has a high
>> impact.  That isn't news.  What I realized this week after hearing more
>> operators describe their workaround is that everybody's workaround is
>> roughly the same: make small changes to the crush map so that only a small
>> number of PGs are backfilling at a time.  In retrospect it seems obvious,
>> but the problem is that our backfill throttling is per-OSD: the "slowest"
>> we can go is 1 backfilling PG per OSD.  (Actually, 2.. one primary and one
>> replica due to separate reservation thresholds to avoid deadlock.)  That
>> means that every OSD is impacted.  Doing fewer PGs doesn't make the
>> recovery vs client scheduling better, but it means it affects fewer PGs
>> and fewer client IOs and the net observed impact is smaller.
>>
>> Anyway, in short, I think we need to be able to set a *global* threshold
>> of "no more than X % of OSDs should be backfilling at a time," which is
>> impossible given the current reservation appoach.
>>
>> This could be done naively by having OSDs reserve a slot via the mon or
>> mgr.  If we only did it for backfill the impact should be minimal (those
>> are big slow long-running operations already).
>>
>> I think you can *almost* do it cleverly by inferring the set of PGs that
>> have to backfill by pg_temp.  However, that doesn't take any priority or
>> stuck PGs into consideration.
>>
>> Anyway, the naive thing probably isn't so bad...
>>
>> 1) PGMap counts backfilling PGs per OSD (and then the number of OSDs with
>> one or more backfilling PGs).
>>
>> 2) For the first step of the backfill (recovery?) reservation, OSDs ask
>> the mgr for a reservation slot.  The reservation is (pgid,interval epoch)
>> so that the mgr can throw out the reservation require without needing an
>> explicit cancellation if there is an interval change.
>>
>> 3) mgr grants as many reservations as it can without (backfilling +
>> grants) > whatever the max is.
>>
>> We can set the max with a global tunable like
>>
>>  max_osd_backfilling_ratio = .3
>>
>> so that only 30% of the osds can be backfilling at once?
>>
>> sage
>
> I think the biggest problem is not how many OSDs are busy, but that any
> single osd is overloaded long enough for a human user to call it laggy
> (eg. "ls" takes 5s because of blocked requests). A setting to say you
> want all osds 30% busy would be better than saying you want 30% of your
> osds overloaded and 70% idle (where another word for idle is wasted).

Yeah, this.

I think your first instinct was right, Sage: the client-visible
backfill impact is mostly a result of poor scheduling and
prioritization. The workaround of minimizing how much work we do at
once is really about reducing the tail size to a level low enough
people don't complain about it, but I think anybody aggregating data
metrics and looking at 99th%ile latencies and expecting some kind of
SLA would remain fairly unhappy with these outcomes. (The other issue
is as Dan notes — peering all at once is very visible; something that
delays only a small percentage of ops means other ops can keep
processing and client VMs don't seize up the same way).

That said, global backfill scheduling has other uses (...and might be
faster to implement than proper prioritization). It lets us restrict
network bandwidth devoted to backfill, not just local disk ops. And a
central daemon like the manager can do better prioritization than the
OSDs are really capable of in the case of degraded stuff (especially
with more complicated things like the undersized level on erasure
coded data across varying rules).
Those use cases make me think we might not want to start with such a
naive approach though. Perhaps OSDs report their personal backfill
limits to the manager when asking for the number of reservations they
want, and the manager decides which ones to issue based on that data,
its global limits, and the priorities it can see in terms of overall
PG states and backfill progress?
(In particular, it may want to "save" reservations for somebody that
is currently a backfill target but will shortly be freeing up a slot
or something.)
-Greg

> The problems with clients seem to happen when they hit an overly busy
> osd, rather than because many are moderately busy. (Is the future QoS
> code supposed to handle this, for recovery [and scrub, snap trim,
> flatten, rbd resize, etc.] not just clients? And I find resize [shrink
> with snaps present] and flatten to be the worst since there appears to
> be no config options to slow them down)
>
> I always have max backfills = 1 and recovery max active = 1, but with my
> small cluster (3 nodes and 36 osds so far), I find that letting it go
> fully parallel is better than trying to make small changes one at a
> time. I have tested things like running fio or xfs_fsr to defrag and
> overloading one osd makes it far worse than having many osds a bit busy.
> And I verified that by putting those things in cgroups where they are
> limited to a certain iops and bandwidth per disk, and then they can't
> cause blocked requests easily.
>
> Peter
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
