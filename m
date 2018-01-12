From: Sage Weil <sweil@redhat.com>
Subject: Re: killing onreadable completions
Date: Fri, 12 Jan 2018 23:48:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801122342020.24931@piezo.novalocal>
References: <alpine.DEB.2.11.1801122137190.8186@piezo.novalocal> <CAJ4mKGaWH-shsF-VNqPo89d25-k_5dsgNv7E085BPciu9XUdUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-806503425-1515800904=:24931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965291AbeALXsY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 18:48:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 774D3883B4
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jan 2018 23:48:24 +0000 (UTC)
In-Reply-To: <CAJ4mKGaWH-shsF-VNqPo89d25-k_5dsgNv7E085BPciu9XUdUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-806503425-1515800904=:24931
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 12 Jan 2018, Gregory Farnum wrote:
> On Fri, Jan 12, 2018 at 1:37 PM, Sage Weil <sweil@redhat.com> wrote:
> > A dream of mine is to kill off the onreadable callback in ObjectStore
> > completely.  This is *mostly* a non-issue with BlueStore with a few
> > exceptions (creates/deletes still need a flush before they are visible to
> > collection_list()), but because FileStore has no in-memory cache/state
> > about it's changes it is a long way from being possible.
> >
> > My thinking recently has been that at some point we'll reach a point where
> > we care more about OSD code simplicity than FileStore performance
> > (presumably at some point after we move a bunch of users over to
> > BlueStore) and then we implement some kludge in FileStore to hide
> > this.
> >
> > Today I was looking at a weird ECBackend issue and it looks like there
> > we're still doing dual acks for commit and readable... all in order to
> > make sure that a read that follows a write will order properly (even on
> > replicas).  That means double the messages over the wire to track
> > something that can be done with a simple map of in-filght objects in
> > memory.  But instead of implementing that just in ECBackend, implementing
> > the same thing in FileStore would kill 100 birds with one stone.
> 
> Can you elucidate on what's happening with ECBackend? I'd assume part
> of the complexity is about maintaining the cache that lets us pipeline
> writes that overlap, and I don't quite see how what you're discussing
> would work with that.
> ...and, actually, now that I think about it I'm not entirely sure the
> bluestore semantics would work for ec overwrite pools without this
> overlay? What are the rules again?

ECBackend is sending messages for both commit and onreadable on sub 
writes, and not completing the write until both are done.  I come up with 
any reason why it would be doing that... except to make sure that on a 
read the previous writes have first applied.  I don't think this is 
related to the cache per se; it's just that any read needs to wait for 
prior writes to apply before proceeding.

(The bug I'm fixing is only peripherally related to this; I just noticed 
that it would go away if we didn't have the onreadable callbacks at all 
and got off on this tangent...)

> > The naive concept is that when you queue_transaction, we put an item in
> > hash tale in the Sequencer indicating a write is in flight for all oids
> > referenced by the Transaction.  When we complete, we remove it from the
> > hash map.  Probably unordered_map<ghobject_t,int> where it's just a
> > counter.  Then, on read ops, we do a wait_for_object(oid) that waits for
> > that count to be zero.  This is basically what the ECBackend-specific fix
> > would need to do in order to get rid of the messages over the wire (and
> > that trade-off is a no-brainer).
> >
> > For ReplicatedPG, it's less obvious, since we already have per-object
> > state in memory that is tracking in-flight requests.  The naive filestore
> > implementation adds a hash map insert and removal + plus some lookups for
> > read ops with the allocation of the callback, and queueing and executing
> > the callback on io apply/completion.  Not sure that's a win for the
> > simple implementation.
> >
> > But: what if we make the tracking super lightweight and efficient?  I'm
> > thinking this, in the OpSequencer:
> >
> >  std::atomic<int> inflight_by_hash[128];
> >
> > where we hash the object id and increment the atomic slot in appropriate
> > slot, then decrement on completion.  That's basically 0 overhead for
> > tracking in the write path.  And for the read path, we just test the slot
> > and (if it's 0) proceed.  If it's not zero, we take the OpSequencer lock
> > and do a more traditional cond wait on the condition (the write path is
> > already taking the qlock on completion so it can signal as needed).
> >
> > This is probabilistic, meaning that if you have a lot of IO in flight on a
> > sequencer (== PG) when you issue a read you might wait for an unrelated
> > object you don't need to, but with low probability.  We can tune the size
> > of the counter vector to balance that probability (and long-tail read
> > latencies in mixed read/write workloads) with memory usage (and I guess L1
> > misses that might slow down flash read workloads a bit).
> 
> So you're...trying to optimize the memory allocation pattern here,
> instead of just maintaining a red-black tree? :)
> If that's the case, it seems like maintaining a hash map with
> preallocated in-place objects (except for collisions, I suppose) is a
> better choice — it won't take many unneeded delays to cancel out any
> increase in memory allocator efficiency! (If you're worried about the
> names not fitting, we can store the raw pgid; that has a lot less
> chance of colliding than a simple %128. Or have a spillover struct for
> longer object names.)

The trivial thing is to make an unordered_map<ghobject_t,int> map of 
in-flight writes.  And the cost of maintainign that is probably okay on 
the write side.

The problem is that on the read side there is currently *no* check at this 
layer for anything, so we would be adding a mutex lock + hash lookup + 
unlock.

And maybe that's actually fine...  I guess I and do a proof of concept 
branch to see!

sage
--8323329-806503425-1515800904=:24931--
