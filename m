From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: removed_snaps
Date: Fri, 13 Oct 2017 15:25:29 -0700
Message-ID: <CAJ4mKGaauoPR9KnHBhp2C50qBypy4q=Sa7pA-WF-BXeNfBAOXQ@mail.gmail.com>
References: <alpine.DEB.2.11.1710111556410.26702@piezo.us.to>
 <CAJ4mKGaw-6Yu5pK97r0GK5q2_Kt=O2d6SG9um+Xvr8JdAKX88A@mail.gmail.com>
 <alpine.DEB.2.11.1710111841060.26702@piezo.us.to> <CAJ4mKGZbPjKNchv+cqcx_uRhb3GtX5D7ZNj-0UHTapbaHascrQ@mail.gmail.com>
 <alpine.DEB.2.11.1710121354490.26702@piezo.us.to> <CAJ4mKGYxQO7QErAkwaaOjrV48M5k-0RVHscn2gjKYs0T3qMyLA@mail.gmail.com>
 <alpine.DEB.2.11.1710132052540.26702@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:44034 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdJMWZa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Oct 2017 18:25:30 -0400
Received: by mail-it0-f42.google.com with SMTP id n195so19523980itg.1
        for <ceph-devel@vger.kernel.org>; Fri, 13 Oct 2017 15:25:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710132052540.26702@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Mclean, Patrick" <Patrick.Mclean@sony.com>

On Fri, Oct 13, 2017 at 2:32 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 13 Oct 2017, Gregory Farnum wrote:
>> Moving on to the stuff actually written down:
>> How comfortable are we with the size of the currently-deleting
>> snapshots maps, for computation purposes? I don't have a good way of
>> quantifying that cost but I'm definitely tempted to split the sets
>> into
>> newly_deleted_snaps (for *this epoch*)
>> deleting_snaps (which are kept around until removed_snaps_lb_epoch)
>> newly_purged_snaps (also for this epoch, which I think is how you have
>> it written?)
>
> The code I have now has 2 sets: removed_snaps and purged_snaps.
> purged_snapd was already there before; removed_snaps is the superset that
> includes stuff not yet purged.  (I made it a superset thinking that
> the filter_snapc() thing on every op will be faster if it only has to
> filter against a single set instead of 2 of them, and that matters more
> than the memory.)

No, what I mean is:
* we know that computing the overlap of interval sets can be expensive
* so we want to only compute overlaps of small sets
* this is especially true if we're doing it on all outstanding
operations in librados, within a single thread

So we definitely don't want to repeat comparisons if we don't have to.
And I suspect there will be occasional periods of intense snapshot
deletion from admins where they remove a number large enough to cause
trouble, and we don't want that to result in noticeably slower IO
submission on the client-side!

So we should have a separate set of snaps which were just added to the
removed_snaps during this epoch, that librados and the OSD map
processing can use in their normal-course-of-business scanning.
-Greg
