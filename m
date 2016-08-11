From: Sage Weil <sweil@redhat.com>
Subject: bluestore locking
Date: Thu, 11 Aug 2016 16:03:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608111555060.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932395AbcHKQDj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Aug 2016 12:03:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath.Roy@sandisk.com
Cc: ceph-devel@vger.kernel.org

After our conversation this mornning I went through the locking a bit more 
and I think we're in okay shape.  To summarize:

These 'forward lookup' structures are protected by coll->lock:

 Bnode::blob_map -> Blob                                    coll->lock
 Onode::blob_map -> Blob                                    coll->lock

These ones are protected by cache->lock:

 Collection::OnodeSpace::onode_map -> Onode (unordered_map)     cache->lock
 Blob::bc -> Buffer                                             cache->lock

The BnodeSet is a bit different because it is depopulated when the last 
onode ref goes away.  But it has its own lock:

 Collection::BnodeSet::uset -> Bnode (intrustive set)       BnodeSet::lock

Anyway, the point of this is that the cache trim() can do everything it 
needs with just cache->lock.  That means that during an update, we 
normally have coll->lock to protect the structures we're touching, and if 
we are adding onodes to OnodeSpace or BufferSpace we additionally take 
cache->lock for the appropriate cache fragment.

We were getting tripped up from the blob_map iteration in _txc_state_proc 
because we were holding no locks at all (or, previously, a collection lock 
that may or may not be the right one).  Igor's PR fixes this by 
making Blob refcounted and keeping a list of these.  The finish_write() 
function takes cache->lock as needed.  Also, it's worth pointing out that 
the blobs that we're touching will all exist under an Onode that is in the 
onodes list, and it turns out that the trim() is already doing the right 
thing and not trimming Onodes that still have any refs.

Which leaves me a bit confused as to how we originally were 
crashing, because we were taking the first_collection lock.  My guess is 
that first_collection was not the right collection and a racing update was 
updating the Onode.  The refcounting alone sorts this out.  My other fix 
would have also resolved it by taking the correct collection's 
lock, I think.  Unless there is another locking problem I'm not seeing.. 
but I think what is in master now has it covered.

Igor, Somnath, does the current strategy make sense?

sage

