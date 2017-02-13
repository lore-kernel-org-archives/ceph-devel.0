From: Sage Weil <sweil@redhat.com>
Subject: Re: crush multipick anomaly
Date: Mon, 13 Feb 2017 21:26:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702132125450.7782@piezo.novalocal>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal> <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org> <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal> <3486c5b8-1d50-5762-c84a-8d1fcecaa775@dachary.org> <alpine.DEB.2.11.1702131913070.7782@piezo.novalocal>
 <365bb618-3718-cd8b-1383-d6f5d51a20cb@dachary.org> <49b7e4ae-dae7-ed51-b5b3-96da5cf37129@dachary.org> <alpine.DEB.2.11.1702132111140.7782@piezo.novalocal> <CAJ4mKGZER6SJyjM-=iOZwyKxHBXHc4qMvRSdnO2mTVH_HvZYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752199AbdBMV0D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 16:26:03 -0500
In-Reply-To: <CAJ4mKGZER6SJyjM-=iOZwyKxHBXHc4qMvRSdnO2mTVH_HvZYFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 13 Feb 2017, Gregory Farnum wrote:
> On Mon, Feb 13, 2017 at 1:15 PM, Sage Weil <sweil@redhat.com> wrote:
> > On Mon, 13 Feb 2017, Loic Dachary wrote:
> >> I get the expected behavior for replica 1 (which is what
> >> CRUSH.straw2_reweight does). The movement between buckets observered
> >> below is for replica 2.
> >
> > Oh, right, now I remember.  The movement for the second replica is
> > unavoidable (as far as I can see).  For the second replica, sometimes we
> > end up picking a dup (the same thing we got for the first
> > replica) and trying again; any change in the behavior of the first choice
> > may mean that we have more or less "second tries."  Although any given try
> > will behave as we like (only moving to or from the reweighted item),
> > adding new tries will pick uniformly.  In your example below, I think all
> > of the second replicas that moved to osds 0-9 were objects that originally
> > picked a dup for the second try and, once 10 was added, did not--because
> > the first replica was now on the new osd 10.
> 
> Just to be clear, that's within a bucket, right?

Right, within a (straw2) bucket.

> Because obviously changing bucket weights in the CRUSH hierarchy will
> move new data to them, not all of which ends up on the new disk.

Yep!

sage
