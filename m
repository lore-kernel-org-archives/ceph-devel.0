From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: RADOS: Deleting all objects in a namespace
Date: Tue, 23 May 2017 22:12:12 -0700
Message-ID: <CAJ4mKGZorBntpTQDBzqdLHamyprOUx_4Abcz_f1RX=afEp45jA@mail.gmail.com>
References: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34740 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbdEXFMO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 01:12:14 -0400
Received: by mail-io0-f175.google.com with SMTP id k91so110761066ioi.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 22:12:14 -0700 (PDT)
In-Reply-To: <CALe9h7eQMGGB1K_W-qryVjYhfjr5jGBRKLkawUr8q=QD1rXTSw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 23, 2017 at 6:10 AM John Spray <jspray@redhat.com> wrote:
>
> Soon, we'll probably be letting multiple CephFS filesystems use the
> same data and metadata pools, where the filesystems are separated by
> rados namespace.
>
> When removing filesystems, in the interests of robustness and speed,
> I'd like to be able to delete all objects in a namespace -- otherwise
> we would have to rely on a "rm -rf" and then some new code to
> explicitly enumerate and delete all metadata objects for that
> filesystem.
>
> I'm pondering whether this should just be a process that happens via
> normal client interfaces (where mon/mgr would be the client), or
> whether it would be feasible/desirable to implement something inside
> the OSD.  Obviously the OSD ultimately has to do the same underlying
> enumeration, but at least it doesn't have to thrash through the whole
> request/response cycle for deleting each object individually -- might
> enable it to throttle internally in the OSD based on how busy it knows
> itself to be, rather than having the client apply some arbitrary "only
> issue N deletions at once" type limit that might make the deletion
> process unecessarily slow.
>
> I have a feeling we must have talked about this at some point but my
> memory is failing me...


This is an interesting thought and I don't think it's been discussed
before. Some random things:
1) We tend to suck at throttling stuff in the OSD (although we're
getting close to having the right pattern)
2) Deleting objects is a *lot* more expensive than listing them;
David's right it would probably look like pgnls, but it's definitely
not analogous. For the listing we just go through omap keys but here
we have to shove deletes into XFS (...for now. I suppose they're
actually pretty similar in BlueStore, though I don't really know the
cost of a delete)
3) If this happens inside the OSD it will be much harder to bill it
against client IO. Not sure if that's relevant given it's removal,
but...
4) I'm actually not sure how we could best do this internally if we
wanted to. Deletes as noted would have to take a while, which means it
would probably be a very long-lived operation — much more than eg 30
seconds. Or else we'd need a whole internal queue of stuff to delete,
where the client "op" is just queueing up the namespace and the actual
deletes get spaced out much later...and then that would imply more new
checks around whether something is logically deleted even though it
still exists in our data store. (And what happens if a user starts
putting new objects in the namespace while the delete is still going
on? Is that blocked somehow? Or does the OSD need to handle it with a
way of distinguishing between namespace "epoch" 1 and 2?)

Overall I definitely see the appeal of wanting to do gross deletes
like that, but it'll be at least a little trickier than I suspect
people are considering. Given the semantic confusion and implied
versus real costs I'm generally not really a fan of allowing stuff
like this on units other than pools/PGs and I'm not sure when the
bandwidth to implement it might come up. How important do you think it
really is compared to doing "rm -rf"?
-Greg
