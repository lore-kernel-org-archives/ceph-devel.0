From: Peter Maloney <peter.maloney@brockmann-consult.de>
Subject: Re: global backfill reservation?
Date: Fri, 12 May 2017 22:49:14 +0200
Message-ID: <99194e05-6bb9-29db-a85b-bf13da36fcf4@brockmann-consult.de>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:62975 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755796AbdELUtX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 May 2017 16:49:23 -0400
In-Reply-To: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 05/12/17 20:53, Sage Weil wrote:
> A common complaint is that recovery/backfill/rebalancing has a high 
> impact.  That isn't news.  What I realized this week after hearing more 
> operators describe their workaround is that everybody's workaround is 
> roughly the same: make small changes to the crush map so that only a small 
> number of PGs are backfilling at a time.  In retrospect it seems obvious, 
> but the problem is that our backfill throttling is per-OSD: the "slowest" 
> we can go is 1 backfilling PG per OSD.  (Actually, 2.. one primary and one 
> replica due to separate reservation thresholds to avoid deadlock.)  That 
> means that every OSD is impacted.  Doing fewer PGs doesn't make the 
> recovery vs client scheduling better, but it means it affects fewer PGs 
> and fewer client IOs and the net observed impact is smaller.
>
> Anyway, in short, I think we need to be able to set a *global* threshold 
> of "no more than X % of OSDs should be backfilling at a time," which is 
> impossible given the current reservation appoach.
>
> This could be done naively by having OSDs reserve a slot via the mon or 
> mgr.  If we only did it for backfill the impact should be minimal (those 
> are big slow long-running operations already).
>
> I think you can *almost* do it cleverly by inferring the set of PGs that 
> have to backfill by pg_temp.  However, that doesn't take any priority or 
> stuck PGs into consideration.
>
> Anyway, the naive thing probably isn't so bad...
>
> 1) PGMap counts backfilling PGs per OSD (and then the number of OSDs with 
> one or more backfilling PGs).
>
> 2) For the first step of the backfill (recovery?) reservation, OSDs ask 
> the mgr for a reservation slot.  The reservation is (pgid,interval epoch) 
> so that the mgr can throw out the reservation require without needing an 
> explicit cancellation if there is an interval change.
>
> 3) mgr grants as many reservations as it can without (backfilling + 
> grants) > whatever the max is.
>
> We can set the max with a global tunable like
>
>  max_osd_backfilling_ratio = .3
>
> so that only 30% of the osds can be backfilling at once?
>
> sage

I think the biggest problem is not how many OSDs are busy, but that any
single osd is overloaded long enough for a human user to call it laggy
(eg. "ls" takes 5s because of blocked requests). A setting to say you
want all osds 30% busy would be better than saying you want 30% of your
osds overloaded and 70% idle (where another word for idle is wasted).
The problems with clients seem to happen when they hit an overly busy
osd, rather than because many are moderately busy. (Is the future QoS
code supposed to handle this, for recovery [and scrub, snap trim,
flatten, rbd resize, etc.] not just clients? And I find resize [shrink
with snaps present] and flatten to be the worst since there appears to
be no config options to slow them down)

I always have max backfills = 1 and recovery max active = 1, but with my
small cluster (3 nodes and 36 osds so far), I find that letting it go
fully parallel is better than trying to make small changes one at a
time. I have tested things like running fio or xfs_fsr to defrag and
overloading one osd makes it far worse than having many osds a bit busy.
And I verified that by putting those things in cgroups where they are
limited to a certain iops and bandwidth per disk, and then they can't
cause blocked requests easily.

Peter

