From: Sage Weil <sweil@redhat.com>
Subject: RE: bluestore locking
Date: Thu, 11 Aug 2016 16:58:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608111655000.17762@piezo.us.to>
References: <alpine.DEB.2.11.1608111555060.17762@piezo.us.to> <BL2PR02MB2115B745A823E78ACDD2738FF41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932489AbcHKQ6Q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 12:58:16 -0400
In-Reply-To: <BL2PR02MB2115B745A823E78ACDD2738FF41E0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 11 Aug 2016, Somnath Roy wrote:
> <<inline with [Somnath]
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Thursday, August 11, 2016 9:04 AM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: bluestore locking
> 
> After our conversation this mornning I went through the locking a bit more and I think we're in okay shape.  To summarize:
> 
> These 'forward lookup' structures are protected by coll->lock:
> 
>  Bnode::blob_map -> Blob                                    coll->lock
>  Onode::blob_map -> Blob                                    coll->lock
> 
> These ones are protected by cache->lock:
> 
>  Collection::OnodeSpace::onode_map -> Onode (unordered_map)     cache->lock
>  Blob::bc -> Buffer                                             cache->lock
> 
> The BnodeSet is a bit different because it is depopulated when the last onode ref goes away.  But it has its own lock:
> 
>  Collection::BnodeSet::uset -> Bnode (intrustive set)       BnodeSet::lock
> 
> Anyway, the point of this is that the cache trim() can do everything it 
> needs with just cache->lock.  That means that during an update, we 
> normally have coll->lock to protect the structures we're touching, and 
> if we are adding onodes to OnodeSpace or BufferSpace we additionally 
> take cache->lock for the appropriate cache fragment.
> 
> We were getting tripped up from the blob_map iteration in 
> _txc_state_proc because we were holding no locks at all (or, previously, 
> a collection lock that may or may not be the right one).  Igor's PR 
> fixes this by making Blob refcounted and keeping a list of these.  The 
> finish_write() function takes cache->lock as needed.  Also, it's worth 
> pointing out that the blobs that we're touching will all exist under an 
> Onode that is in the onodes list, and it turns out that the trim() is 
> already doing the right thing and not trimming Onodes that still have 
> any refs.
> 
> [Somnath] The crash we are not seeing in the current code as it is 
> protected by first_collection lock in _txc_state_*. But, that patch 
> opened up a deadlock like this.
> 
> Thread 1 -> coll->Wlock -> onode->flush() -> waiting for unfinished txc
> Thread 2 -> _txc_finish_io -> _txc_state_* -> coll->Rlock
> 
> There is a small window as txcs are added in the o->flush_txns list 
> after _txc_add release coll->Wlock()
> 
> BTW, the crash is happening as iterator got invalidated and not because 
> blob is deleted (which eventually may hit that). Making blob ref counted 
> will not be solving that the blob is been erased from the blob_map set. 
> We need to protect that with a lock.

Well, the blob refcounting fixes the deadlock certainly, bc we no longer 
need collection lock in that path.  So the question remaining is if 
there is a locking issue still...
 
> Which leaves me a bit confused as to how we originally were crashing, 
> because we were taking the first_collection lock.  My guess is that 
> first_collection was not the right collection and a racing update was 
> updating the Onode.  The refcounting alone sorts this out.  My other fix 
> would have also resolved it by taking the correct collection's lock, I 
> think.  Unless there is another locking problem I'm not seeing.. but I 
> think what is in master now has it covered.

And I think there isn't.  We no longer use an iterator (since we have the 
list of blobs to fix up), and the blob finish_write stuff is protected by 
cache->lock.  So I think this shoudl resolve it.  But.. whatever workload 
you were using that triggered this before, perhaps you can run it 
again?

> [Somnath] As I mentioned above , after taking first_collection lock we 
> were not crashing anymore , it was the deadlock we were hitting. So, the 
> fix would be to protect blob_map with a lock. If it is cool->lock we are 
> hitting deadlock , if it is cache->lock() we need to see. The PR I sent 
> is introducing a blob_map lock and fixing this.
> 
> But, Mark was hitting a onode corruption and initially I thought it is 
> because trim() is *not invoked* within coll->lock() from 
> _osr_reap_done(). The fix in the PR seems to be working for him and if 
> so, trim() is the one is deleting that and we don't have explanation how 
> it happened. Is there any place in the code other than trim() can delete 
> onode ? I couldn't find any..

What is the workload here?  And can you retest with master now?  Trim 
shouldn't need any lock at all (it takes cache->lock on its own).  The 
open question is whether there are other paths that are touching 
cache->lock protected things that aren't taking cache->lock.  I don't 
think so, but verifying with the problematic workloads will give us more 
confidence...

sage
