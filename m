From: Dan van der Ster <dan@vanderster.com>
Subject: Re: global backfill reservation?
Date: Sat, 13 May 2017 18:55:04 +0200
Message-ID: <CABZ+qqmtqL7Dgzu4XNsfyqgdJRZrkRXbfxRaRH+1bWg8zvDCBA@mail.gmail.com>
References: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35346 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbdEMQzq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 13 May 2017 12:55:46 -0400
Received: by mail-oi0-f42.google.com with SMTP id l18so94649492oig.2
        for <ceph-devel@vger.kernel.org>; Sat, 13 May 2017 09:55:46 -0700 (PDT)
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id w186sm3176157oib.38.2017.05.13.09.55.44
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 09:55:45 -0700 (PDT)
Received: by mail-oi0-f43.google.com with SMTP id h4so94599696oib.3
        for <ceph-devel@vger.kernel.org>; Sat, 13 May 2017 09:55:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1705112237290.18953@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, May 12, 2017 at 8:53 PM, Sage Weil <sweil@redhat.com> wrote:
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

+1, this is something I've wanted for awhile. Using my "gentle
reweight" scripts, I've found that backfilling stays pretty
transparent as long as we limit to <5% of OSDs backfilling on our
large clusters. I think it will take some experimentation to find the
best default ratio to ship.

On the other hand, the *other* reason that we operators like to make
small changes is to limit the number of PGs that go through peering
all at once. Correct me if I'm wrong, but as an operator I'd hesitate
to trigger a re-peering of *all* PGs in an active pool -- users would
surely notice such an operation. Does luminous or luminous++ have some
improvements to this half of the problem?

Cheers, Dan
