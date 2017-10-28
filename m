From: Sage Weil <sage@redhat.com>
Subject: removed_snaps update
Date: Sat, 28 Oct 2017 19:54:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710272145350.11501@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbdJ1Tyg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 28 Oct 2017 15:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2AB1C0587E3
        for <ceph-devel@vger.kernel.org>; Sat, 28 Oct 2017 19:54:35 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: gfarnum@redhat.com

I've run into a familiar wall with the remove_snaps improvements: cache 
tiering!  Yay.

SnapSet has a vector<snapid_t> snaps member for the logical snapshots most 
recently observed for the object.  This is stored on the head object.  If 
we write an object with, say, [1,2,3], and then later trim 2, we don't 
update the SnapSet.  (In contrast, if we had created a clone because snap 
4 was created and the object was updated again, the clone would be defined 
for that snap and the SnapMapper would have found it and fixed it up.  
But snap trimming does not touch head objects with no clones and we 
*probably* don't want to change that.)

This matters... almost not at all.  There isn't a very good reason anymore 
(that I can identify) for having snaps in SnapSet.  Except for cache 
tiering!  And there, it comes up twice:

1) When we promote a *clone* from the base tier head object.  This only 
happens when you have partially flushed clones, then trimmed the clone 
from the cache, then promote again.  For example,

write 3=[1,2,3] into cache
flush it to base, mark it clean
 -> base has head with SnapSet 3=[1,2,3]
write 4=[1,2,3,4] into cache
 -> creates clone 3=[1,2,3]
 -> head SnapSet has 4=[1,2,3,4]:{3=[1,2,3]}
evict clone 3 from cache
promote clone 3 from base head
 -> here, we use the head's SnapSet to figure out which clones the clone 
is defined on.

I think we have that info in the cache's head's SnapSet clone_snaps, so 
*think* this should be avoidable.

2) When we flush from the cache tier to the base tier, if there are 
snaps, we construct a SnapContext such that we'll create a correct clone.  
For example,

write 3=[1,2,3] into cache
flush it to base, mark it clean
write 4=[1,2,3,4] into cache
 -> creates clone 3=[1,2,3]
 -> head SnapSet has 4=[1,2,3,4]:{3=[1,2,3]}
flush head to base
 -> we construct a SnapContext based on SnapSet so that we'll end up with 
the same 3=[1,2,3] clone in the base tier.

Ick.  This would require a change to the flush process that explicitly 
specifies what the clone_snaps are.  Doable, I guess, but a freaking 
pain in my butt.

In conclusion, we need to change up the way the cache tier behaves in 
order to fully remove removed_snaps.

--

My other conclusion: I don't think we need to worry (much) about the 
potential for a client to send a SnapContext with old snaps (ones that 
have been removed).  If we do nothing, worst case, we "leak" a clone, 
which isn't so bad.

But... I think it's easy to clean up.  If we ever get a request on an 
object and the SnapContext has a higher seq than the SnapSet, and there is 
a clone for that object for a snapid that does not exist in the 
SnapContext snap list, then either (1) the snap was *just* removed and the 
OSD just hasn't heart about it yet, or (2) the clone is the result of the 
OSD seeing a stale snapc.  If we can come up with a way to avoid breaking 
'normal' operation in the (1) case, then we can simply requeue the snapid 
for purge to capture (2)... which will end up cleaning up any other clones 
for that snapid on the current OSD as well.

--

In short, I think the plan has to be something like this:

1. change the snap trimming/purging so that it uses the per-epoch lists 
(like my current branch).  do not touch pg_pool_t::removed_snaps, though!

2. keep the Objecter fixes that sanitize the SnapContext on the client 
side.

3. remove any dependency on SnapSet::snaps:

 3a. change cache flush/promote so that they are explicit about the snaps 
that clones map to on promote, and on flush, induce the clone to happen at 
flush time when we know which snaps it maps to (before we've 
possibly evicted the clone from the cache).

 3b. remove the snapc pull-forward behavior when the client snapc seq is 
older than the OSD's SnapSet seq.  (We don't care about snaps in this case
because a snapc.seq == snapset.seq means we won't be making a clone in 
make_writeable().)

4. In a year and a half (after nautilus), we can drop SnapSet::snaps... 
and *then* we'll be able to get rid of pg_pool_t::removed_snaps.  Until 
then, we need to keep it for compatibility.

That sounds like a sucky plan (two releases is a long time!) except: the 
performance problem we currently have seen with big removed_snaps is (1) 
inefficient interval_set compares in the PG code figuring out which snaps 
to purge.  This goes away with 1 above.  And (2), we do the filter_snapc 
thing on incoming requests (nobody has complained about this but I suspect 
it is dragging down performance on aged RBD pools).  For that one we can 
make this less frequently by only doing the comparison if the snapc.seq != 
snapset.seq (i.e., we may potentially have to clone).

I'm going to start with a minimal series that just does #1 and #2, since 
that will be a net improvement even if we don't move forward with anything 
else.

sage
