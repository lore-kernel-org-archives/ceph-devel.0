From: Sage Weil <sweil@redhat.com>
Subject: Re: Notes from a discussion a design to allow EC overwrites
Date: Fri, 13 Nov 2015 05:35:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511130524120.7964@cobra.newdream.net>
References: <CAN=+7FUAd-Cc0=1yCekY1QjQ2DJR7WYLLv2OhR_0H5qo5DNgkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34698 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042AbbKMNfJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Nov 2015 08:35:09 -0500
In-Reply-To: <CAN=+7FUAd-Cc0=1yCekY1QjQ2DJR7WYLLv2OhR_0H5qo5DNgkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Samuels, Allen" <allen.samuels@sandisk.com>, "Durgin, Josh" <jdurgin@redhat.com>, "Farnum, Gregory" <gfarnum@redhat.com>

On Thu, 12 Nov 2015, Samuel Just wrote:
> I was present for a discussion about allowing EC overwrites and thought it
> would be good to summarize it for the list:
> 
> Commit Protocol:
> 1) client sends write to primary
> 2) primary reads in partial stripes needed for partial stripe
> overwrites from replicas
> 3) primary sends prepares to participating replicas and queues its own
> prepare locally
> 4) once all prepares are complete, primary sends a commit to the client
> 5) primary sends applies to all participating replicas
> 
> When we get the prepare, we write out a temp object with the data to be
> written.  On apply, we use an objectstore primitive to atomically move those
> extents into the actual object.  The log entry contains the name/id for the
> temp object so it can be applied on apply or removed on rollback.

Currently we assume that temp objects are/can be cleared out on restart.  
This will need to change.  And we'll need to be careful that they get 
cleaned out when peering completes (and the rollforward/rollback decision 
is made.

If the stripes are small, then the objectstore primitive may not actually 
be that efficient.  I'd suggest also hinting that the temp object will be 
swapped later, so that the backend can, if it's small, store it in a cheap 
temporary location in the expectation that it will get rewritten later.  
(In particular, the newstore allocation chunk is currently targetting 
512kb, and this will only be efficient with narrow stripes, so it'll just 
get double-written.  We'll want to keep the temp value in the kv store 
[log, hopefully] and not bother to allocate disk and rewrite it.)

> Each log entry contains a list of the shard ids modified.  During peering, we
> use the same protocol for choosing the authoritative log for the existing EC
> pool, except that we first take the longest candidate log and use it to extend
> shorter logs until they hit an entry they should have witnessed, but didn't.
> 
> Implicit in the above scheme is the fact that if an object is written, but a
> particular shard isn't changed, the osd with that shard will have a copy of the
> object with the correct data, but an out of date object_into (notably, the
> version will be old).  To avoid this messing up the missing set during the log
> scan on OSD start, we'll skip log entries we wouldn't have participated in (we
> may not even choose to store them, see below).  This does generally pose a
> challenge for maintaining prior_version.  It seems like it shouldn't be much of
> a problem since rollbacks can only happen on prepared log entries which haven't
> been applied, so log merging can never result in a divergent entry causing a
> missing object.  I think we can get by without it then?
> 
> We can go further with the above and actually never persist a log entry on a
> shard which it did not participate in.  As long as peering works correctly, the
> union of the logs we got must have all entries.  The primary will need to keep
> a complete copy in memory to manage dup op detection and recovery, however.

That sounds more complex to me.  Maybe instead we could lazily persist the 
entries (on the next pg write) so that it is always a contiguous sequence?

> 2) above can also be done much more efficiently.  Some codes will allow the
> parity chunks to be reconstructed more efficiently, so some thought will
> have to go into restructuring the plugin interface to allow more efficient

Hopefully the stripe size is chosen such that most writes will end up 
being full stripe writes (we should figure out if the EC performance 
degrades significantly in that case?).

An alternative would be to do something like

1) client sends write to primary
2) primary sends prepare to the first M+1 shards, who write it in a 
temporary object/location
3) primary acks write once they ack
4) asynchronously, primary recalculates the affected stripes and 
sends an overwrite.

 - step 4 doesn't need to be 2-phase, since we have the original data 
persisted already on >M shards
 - the client-observed latency is bounded by only M+1 OSDs (not 
acting.size())

I suspect you discussed this option, though, and have other concerns 
around its complexity?

sage
