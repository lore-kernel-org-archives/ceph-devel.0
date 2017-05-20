From: Ning Yao <zay11022@gmail.com>
Subject: Re: global backfill reservation?
Date: Sat, 20 May 2017 22:24:23 +0800
Message-ID: <CALZt5jxT8WvD9hiPVf_YUy3pxWR3pgHW0ZiQo2+YyeiB=Jya_Q@mail.gmail.com>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36522 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdETOYY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 20 May 2017 10:24:24 -0400
Received: by mail-io0-f177.google.com with SMTP id o12so61411970iod.3
        for <ceph-devel@vger.kernel.org>; Sat, 20 May 2017 07:24:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I think the most efficient way to solve this problem is not to
restrict the number of backfilling pgs.  The reason why they want to
reduce backfilling pgs at the same time is because this is the only
thing we can do in Ceph currently. As David mentioned above, reducing
the active backfilling pgs at a time will increase the total recovery
time, which in turn leads to lower reliability and increase the data
loss probability.

Actually, for end-users, they do not care what happens in the ceph
backend. They wanna if there is enough bandwidth, then recover my data
as fast as possible. But at the same time, they want the user IO is
served first. That means if the cluster has 10GB/s, 100k iops IO
bandwidth, at night, user IO cost 20% bandwidth so that 80% bandwidth
for recovery, while at daytime, user IO cost 80% bandwidth  so that
20% bandwidth for recovery. so it seems pretty reasonable to do it
with dynamic QoS strategy and serve the user IO first at anytime. Only
in this way, it can achieve the final goal for this issue.

Therefore
Regards
Ning Yao


2017-05-13 2:53 GMT+08:00 Sage Weil <sweil@redhat.com>:
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
