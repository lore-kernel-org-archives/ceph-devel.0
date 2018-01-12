From: Sage Weil <sweil@redhat.com>
Subject: Re: killing onreadable completions
Date: Fri, 12 Jan 2018 22:21:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801122206540.8186@piezo.novalocal>
References: <alpine.DEB.2.11.1801122137190.8186@piezo.novalocal> <CADRKj5Q6j_X9bS5UZoKjR8exaVpOzMVEV_VpMqksaGxt49wDyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965212AbeALWVC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 17:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CF57C0828CA
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jan 2018 22:21:02 +0000 (UTC)
In-Reply-To: <CADRKj5Q6j_X9bS5UZoKjR8exaVpOzMVEV_VpMqksaGxt49wDyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, jdurgin <jdurgin@redhat.com>

On Fri, 12 Jan 2018, Yehuda Sadeh-Weinraub wrote:
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
> >
> > The naive concept is that when you queue_transaction, we put an item in
> > hash tale in the Sequencer indicating a write is in flight for all oids
> > referenced by the Transaction.  When we complete, we remove it from the
> > hash map.  Probably unordered_map<ghobject_t,int> where it's just a
> > counter.  Then, on read ops, we do a wait_for_object(oid) that waits for
> > that count to be zero.  This is basically what the ECBackend-specific fix
> > would need to do in order to get rid of the messages over the wire (and
> > that trade-off is a no-brainer).
> 
> Can continuous consecutive writes to the same oid lead to starvation?

In the naive case where we track by ghobject_t, or the ECBackend-specic 
hack, no... the OSD is already switching between read-mode and write-mode 
for the object, so it's just making sure the read is delayed long enough 
for the previous write(s) to apply.

For the hashed approach below, it would be a problem, though, since an 
unrelated object that hashes to the same bin could starve an otherwise 
idle object from being able to read.

Perhaps in addition to the count we stash pointers to the ghobjects_t's in 
a per-bin vector?  Something like

 struct slot {
   std::atomic<int> count;
   deque<ghobject_t*> objs;
 };
 vector<slot> slots[128];

so that the read path can usually check the atomic and proceed, but in the 
collission case it'll have to take the qlock and check the in-flight 
objects.

Hrm.
sage


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
> >
> > In return, we completely eliminate the ObjectStore onreadable callback
> > infrastructure and all of the grossness in OSD that uses it.
> >
> > What do you think?
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
