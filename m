From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: killing onreadable completions
Date: Fri, 12 Jan 2018 15:09:34 -0800
Message-ID: <CAJ4mKGaWH-shsF-VNqPo89d25-k_5dsgNv7E085BPciu9XUdUQ@mail.gmail.com>
References: <alpine.DEB.2.11.1801122137190.8186@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:41102 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965260AbeALXJg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jan 2018 18:09:36 -0500
Received: by mail-it0-f45.google.com with SMTP id b77so10888642itd.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jan 2018 15:09:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801122137190.8186@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Fri, Jan 12, 2018 at 1:37 PM, Sage Weil <sweil@redhat.com> wrote:
> A dream of mine is to kill off the onreadable callback in ObjectStore
> completely.  This is *mostly* a non-issue with BlueStore with a few
> exceptions (creates/deletes still need a flush before they are visible to
> collection_list()), but because FileStore has no in-memory cache/state
> about it's changes it is a long way from being possible.
>
> My thinking recently has been that at some point we'll reach a point where
> we care more about OSD code simplicity than FileStore performance
> (presumably at some point after we move a bunch of users over to
> BlueStore) and then we implement some kludge in FileStore to hide
> this.
>
> Today I was looking at a weird ECBackend issue and it looks like there
> we're still doing dual acks for commit and readable... all in order to
> make sure that a read that follows a write will order properly (even on
> replicas).  That means double the messages over the wire to track
> something that can be done with a simple map of in-filght objects in
> memory.  But instead of implementing that just in ECBackend, implementing
> the same thing in FileStore would kill 100 birds with one stone.

Can you elucidate on what's happening with ECBackend? I'd assume part
of the complexity is about maintaining the cache that lets us pipeline
writes that overlap, and I don't quite see how what you're discussing
would work with that.
...and, actually, now that I think about it I'm not entirely sure the
bluestore semantics would work for ec overwrite pools without this
overlay? What are the rules again?

>
> The naive concept is that when you queue_transaction, we put an item in
> hash tale in the Sequencer indicating a write is in flight for all oids
> referenced by the Transaction.  When we complete, we remove it from the
> hash map.  Probably unordered_map<ghobject_t,int> where it's just a
> counter.  Then, on read ops, we do a wait_for_object(oid) that waits for
> that count to be zero.  This is basically what the ECBackend-specific fix
> would need to do in order to get rid of the messages over the wire (and
> that trade-off is a no-brainer).
>
> For ReplicatedPG, it's less obvious, since we already have per-object
> state in memory that is tracking in-flight requests.  The naive filestore
> implementation adds a hash map insert and removal + plus some lookups for
> read ops with the allocation of the callback, and queueing and executing
> the callback on io apply/completion.  Not sure that's a win for the
> simple implementation.
>
> But: what if we make the tracking super lightweight and efficient?  I'm
> thinking this, in the OpSequencer:
>
>  std::atomic<int> inflight_by_hash[128];
>
> where we hash the object id and increment the atomic slot in appropriate
> slot, then decrement on completion.  That's basically 0 overhead for
> tracking in the write path.  And for the read path, we just test the slot
> and (if it's 0) proceed.  If it's not zero, we take the OpSequencer lock
> and do a more traditional cond wait on the condition (the write path is
> already taking the qlock on completion so it can signal as needed).
>
> This is probabilistic, meaning that if you have a lot of IO in flight on a
> sequencer (== PG) when you issue a read you might wait for an unrelated
> object you don't need to, but with low probability.  We can tune the size
> of the counter vector to balance that probability (and long-tail read
> latencies in mixed read/write workloads) with memory usage (and I guess L1
> misses that might slow down flash read workloads a bit).

So you're...trying to optimize the memory allocation pattern here,
instead of just maintaining a red-black tree? :)
If that's the case, it seems like maintaining a hash map with
preallocated in-place objects (except for collisions, I suppose) is a
better choice — it won't take many unneeded delays to cancel out any
increase in memory allocator efficiency! (If you're worried about the
names not fitting, we can store the raw pgid; that has a lot less
chance of colliding than a simple %128. Or have a spillover struct for
longer object names.)
-Greg

>
> In return, we completely eliminate the ObjectStore onreadable callback
> infrastructure and all of the grossness in OSD that uses it.
>
> What do you think?
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
