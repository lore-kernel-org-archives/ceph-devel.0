From: Sage Weil <sweil@redhat.com>
Subject: killing onreadable completions
Date: Fri, 12 Jan 2018 21:37:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1801122137190.8186@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965220AbeALVh0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 16:37:26 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 679E8D713F
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jan 2018 21:37:26 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jdurgin@redhat.com

A dream of mine is to kill off the onreadable callback in ObjectStore 
completely.  This is *mostly* a non-issue with BlueStore with a few 
exceptions (creates/deletes still need a flush before they are visible to 
collection_list()), but because FileStore has no in-memory cache/state 
about it's changes it is a long way from being possible.

My thinking recently has been that at some point we'll reach a point where 
we care more about OSD code simplicity than FileStore performance 
(presumably at some point after we move a bunch of users over to 
BlueStore) and then we implement some kludge in FileStore to hide 
this.

Today I was looking at a weird ECBackend issue and it looks like there 
we're still doing dual acks for commit and readable... all in order to 
make sure that a read that follows a write will order properly (even on 
replicas).  That means double the messages over the wire to track 
something that can be done with a simple map of in-filght objects in 
memory.  But instead of implementing that just in ECBackend, implementing 
the same thing in FileStore would kill 100 birds with one stone.

The naive concept is that when you queue_transaction, we put an item in 
hash tale in the Sequencer indicating a write is in flight for all oids 
referenced by the Transaction.  When we complete, we remove it from the 
hash map.  Probably unordered_map<ghobject_t,int> where it's just a 
counter.  Then, on read ops, we do a wait_for_object(oid) that waits for 
that count to be zero.  This is basically what the ECBackend-specific fix 
would need to do in order to get rid of the messages over the wire (and 
that trade-off is a no-brainer).

For ReplicatedPG, it's less obvious, since we already have per-object 
state in memory that is tracking in-flight requests.  The naive filestore 
implementation adds a hash map insert and removal + plus some lookups for 
read ops with the allocation of the callback, and queueing and executing 
the callback on io apply/completion.  Not sure that's a win for the 
simple implementation.

But: what if we make the tracking super lightweight and efficient?  I'm 
thinking this, in the OpSequencer:

 std::atomic<int> inflight_by_hash[128];

where we hash the object id and increment the atomic slot in appropriate 
slot, then decrement on completion.  That's basically 0 overhead for 
tracking in the write path.  And for the read path, we just test the slot 
and (if it's 0) proceed.  If it's not zero, we take the OpSequencer lock 
and do a more traditional cond wait on the condition (the write path is 
already taking the qlock on completion so it can signal as needed).

This is probabilistic, meaning that if you have a lot of IO in flight on a 
sequencer (== PG) when you issue a read you might wait for an unrelated 
object you don't need to, but with low probability.  We can tune the size 
of the counter vector to balance that probability (and long-tail read 
latencies in mixed read/write workloads) with memory usage (and I guess L1 
misses that might slow down flash read workloads a bit).

In return, we completely eliminate the ObjectStore onreadable callback 
infrastructure and all of the grossness in OSD that uses it.

What do you think?
sage
