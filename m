From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: snap_trimming + backfilling is inefficient with many
 purged_snaps
Date: Sun, 21 Sep 2014 14:26:51 +0000
Message-ID: <7305be37366a5eadf5a3114efe1b0383@webmail.vanderster.com>
References: <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com>
 <CAPUexz-ff+fTmU0J0TrJ80p+6334BBPvM7EWW5=eGa8uEomRew@mail.gmail.com>
 <D197E5D4-598B-4574-852E-C9F0CA10133E@cern.ch>
 <CAPUexz9XeNMJvjCeM_7N0_TQOS6_xBOdgnKm9j4FNDib3+FjMg@mail.gmail.com>
 <541b2add.ea5cb40a.250c.3ed0SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAPUexz_H7-b8SY6J+dLnAyw663eHXoLKYccB1edwH9XgFBZCpw@mail.gmail.com>
 <07f3373f39ff2f738d76bc9f23f07297@webmail.vanderster.com>
 <CAPUexz9P264L4fj4eSdb3KbnTS+ewvE7WdKCw5ijjEO_u8URYA@mail.gmail.com>
 <alpine.DEB.2.00.1409181446110.19460@cobra.newdream.net>
 <CAPUexz-HXn=x_b=CJev46jWFsSrUpXc7UO7kzWcRe4Yrm6VL3g@mail.gmail.com>
 <alpine.DEB.2.00.1409181526260.19460@cobra.newdream.net>
 <CAPUexz-GYF4R95k8QzvdGDKtzez0Qm6SnJt1=4YJEGB8ty7Ggg@mail.gmail.com>
 <1878E4A4-2363-4717-ABEC-B587B0337D6B@cern.ch>
 <CABZ+qqks_qSbgG4QhkaH8A1zTP=o+fR4ptHPbtA9-MxrM8sJ5w@mail.gmail.com>
 <alpine.DEB.2.00.1409190819070.18018@cobra.newdream.net>
 <63ccef299522995cc0704e349ef86503@webmail.vanderster.com>
 <CAME-gARt1NZmEFj6SCpxkfxnibXyR7+AdYKO4YNkQc_n+XJuXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:55844 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbaIUO0y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Sep 2014 10:26:54 -0400
In-Reply-To: <CAPUexz-L=3O0qCkLWiW2UxUfJ0ryOLfO2w7A=kacOLoFui7ceA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

Hi Florian,

September 21 2014 3:33 PM, "Florian Haas" <florian@hastexo.com> wrote: 
> That said, I'm not sure that wip-9487-dumpling is the final fix to the
> issue. On the system where I am seeing the issue, even with the fix
> deployed, osd's still not only go crazy snap trimming (which by itself
> would be understandable, as the system has indeed recently had
> thousands of snapshots removed), but they also still produce the
> previously seen ENOENT messages indicating they're trying to trim
> snaps that aren't there.
> 

You should be able to tell exactly how many snaps need to be trimmed. Check the current purged_snaps with

ceph pg x.y query

and also check the snap_trimq from debug_osd=10. The problem fixed in wip-9487 is the (mis)communication of purged_snaps to a new OSD. But if in your cluster purged_snaps is "correct" (which it should be after the fix from Sage), and it still has lots of snaps to trim, then I believe the only thing to do is let those snaps all get trimmed. (my other patch linked sometime earlier in this thread might help by breaking up all that trimming work into smaller pieces, but that was never tested).

Entering the realm of speculation, I wonder if your OSDs are getting interrupted, marked down, out, or crashing before they have the opportunity to persist purged_snaps? purged_snaps is updated in ReplicatedPG::WaitingOnReplicas::react, but if the primary is too busy to actually send that transaction to its peers, so then eventually it or the new primary needs to start again, and no progress is ever made. If this is what is happening on your cluster, then again, perhaps my osd_snap_trim_max patch could be a solution.

Cheers, Dan

> That system, however, has PGs marked as recovering, not backfilling as
> in Dan's system. Not sure if wip-9487 falls short of fixing the issue
> at its root. Sage, whenever you have time, would you mind commenting?
> 
> Cheers,
> Florian
