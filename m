From: Sage Weil <sage@newdream.net>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 14:23:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702081419490.7782@piezo.novalocal>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53392 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753903AbdBHOaz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 09:30:55 -0500
In-Reply-To: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 8 Feb 2017, John Spray wrote:
> So I've just finished upgrading my home cluster OSDs to bluestore by
> killing them one by one and then letting backfill happen to "new" OSDs
> on the same drives.  Hooray!
> 
> One slightly awkward thing I ran into was that even though I had noout
> set throughout, during the period between removing the old OSD and
> adding the "new" one, some PGs would of course get remapped (and start
> generating backfill IO to third party OSDs).  This does make sense
> when you think about it (noout doesn't make the cluster magically
> remember OSDs that have been removed), but is still an undesirable
> behaviour.
> 
> A) Do we currently have a mechanism to tell the cluster "even though I
> removed this OSD, don't go moving PGs around just yet"?  Should we add
> one?

There's 'ceph osd set norebalance'...

> B) Was there a way for me to avoid this by e.g. skipping the "osd rm
> X" and "osd crush rm osd.X" that I'm currently doing before adding the
> new OSD that will take the old OSD's ID?

This keeps coming up but I don't think we've ever proposed a good 
solution.  Perhaps the simplest thing is to allow ceph-disk to take an OSD 
id as an argument.  Normally this is probably a no-no since the OSD might 
exist elsewhere and have real data on it, and you don't want multiple OSDs 
with the same id, but we could make this safer by requiring that the 
OSD be marked 'lost' before it's id can be reused...

sage
