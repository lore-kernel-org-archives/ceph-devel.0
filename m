From: Sage Weil <sweil@redhat.com>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 14:53:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702081451280.7782@piezo.novalocal>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com> <alpine.DEB.2.11.1702081419490.7782@piezo.novalocal> <108f414f-9ff8-6d05-d406-e73a157151ec@kirneh.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751439AbdBHOyB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Feb 2017 09:54:01 -0500
In-Reply-To: <108f414f-9ff8-6d05-d406-e73a157151ec@kirneh.eu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henrik Korkuc <lists@kirneh.eu>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 8 Feb 2017, Henrik Korkuc wrote:
> On 17-02-08 16:23, Sage Weil wrote:
> > On Wed, 8 Feb 2017, John Spray wrote:
> > > So I've just finished upgrading my home cluster OSDs to bluestore by
> > > killing them one by one and then letting backfill happen to "new" OSDs
> > > on the same drives.  Hooray!
> > > 
> > > One slightly awkward thing I ran into was that even though I had noout
> > > set throughout, during the period between removing the old OSD and
> > > adding the "new" one, some PGs would of course get remapped (and start
> > > generating backfill IO to third party OSDs).  This does make sense
> > > when you think about it (noout doesn't make the cluster magically
> > > remember OSDs that have been removed), but is still an undesirable
> > > behaviour.
> > > 
> > > A) Do we currently have a mechanism to tell the cluster "even though I
> > > removed this OSD, don't go moving PGs around just yet"?  Should we add
> > > one?
> > There's 'ceph osd set norebalance'...
> > 
> > > B) Was there a way for me to avoid this by e.g. skipping the "osd rm
> > > X" and "osd crush rm osd.X" that I'm currently doing before adding the
> > > new OSD that will take the old OSD's ID?
> > This keeps coming up but I don't think we've ever proposed a good
> > solution.  Perhaps the simplest thing is to allow ceph-disk to take an OSD
> > id as an argument.  Normally this is probably a no-no since the OSD might
> > exist elsewhere and have real data on it, and you don't want multiple OSDs
> > with the same id, but we could make this safer by requiring that the
> > OSD be marked 'lost' before it's id can be reused...
> what about "replace"? It could remove old osd from the crush and add new one
> in same location under new id, setting all params to be the same (weight,
> reweight, affinity)?

The problem is that one of the inputs to CRUSH's pseudorandom placement 
decision is the OSD id.  If the id changes, even if the OSD in the same 
position in the hierarchy, that OSD will get a different pseudorandom 
subset of the PGs.

sage
