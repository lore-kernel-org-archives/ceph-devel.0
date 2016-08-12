From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: bluestore locking
Date: Fri, 12 Aug 2016 17:25:40 +0300
Message-ID: <0dad6e8f-eac8-a312-c5e4-4a3d5ba672a9@mirantis.com>
References: <alpine.DEB.2.11.1608111555060.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38766 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbcHLOZo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 10:25:44 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so37333005wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 07:25:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608111555060.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Somnath.Roy@sandisk.com
Cc: ceph-devel@vger.kernel.org

In general the approach looks good.

But I have some concerns about cache->lock use. Currently it's usage is 
far from transparent and IMHO is potentially error prone.

The major issue with it is that there is no single entity that provides 
a protected access. We use it from ONodeSpace, BufferSpace, BlueStore, 
Cache class descendants...

Some of their methods are protected with this lock, some ( public ones!) 
aren't. Sometimes there are comments that corresponding method has to be 
invoked under such lock, sometimes not.

Even a variable name for the lock is too general and it's hard to 
determine all the locations where it's used.

IMO this makes future maintenance and code evolution a difficult and 
highly error prone task.

Probably we should consider some refactoring on that to make all the 
staff more manageable.


Another topic irrelevant to the above.

Don't we have a potential unprotected gap for _remove_collection?

It acquires coll_lock and then enumerates onode_map for object presence 
( that's protected by the cache lock) and then proceeds with the 
collection removal from coll_map.

What will happen if someone inserts an object to the collection after an 
enumeration but prior to collection removal, e.g. by calling touch. Is 
this possible or I missed something?


Thanks,

Igor



On 11.08.2016 19:03, Sage Weil wrote:
> After our conversation this mornning I went through the locking a bit more
> and I think we're in okay shape.  To summarize:
>
> These 'forward lookup' structures are protected by coll->lock:
>
>   Bnode::blob_map -> Blob                                    coll->lock
>   Onode::blob_map -> Blob                                    coll->lock
>
> These ones are protected by cache->lock:
>
>   Collection::OnodeSpace::onode_map -> Onode (unordered_map)     cache->lock
>   Blob::bc -> Buffer                                             cache->lock
>
> The BnodeSet is a bit different because it is depopulated when the last
> onode ref goes away.  But it has its own lock:
>
>   Collection::BnodeSet::uset -> Bnode (intrustive set)       BnodeSet::lock
>
> Anyway, the point of this is that the cache trim() can do everything it
> needs with just cache->lock.  That means that during an update, we
> normally have coll->lock to protect the structures we're touching, and if
> we are adding onodes to OnodeSpace or BufferSpace we additionally take
> cache->lock for the appropriate cache fragment.
>
> We were getting tripped up from the blob_map iteration in _txc_state_proc
> because we were holding no locks at all (or, previously, a collection lock
> that may or may not be the right one).  Igor's PR fixes this by
> making Blob refcounted and keeping a list of these.  The finish_write()
> function takes cache->lock as needed.  Also, it's worth pointing out that
> the blobs that we're touching will all exist under an Onode that is in the
> onodes list, and it turns out that the trim() is already doing the right
> thing and not trimming Onodes that still have any refs.
>
> Which leaves me a bit confused as to how we originally were
> crashing, because we were taking the first_collection lock.  My guess is
> that first_collection was not the right collection and a racing update was
> updating the Onode.  The refcounting alone sorts this out.  My other fix
> would have also resolved it by taking the correct collection's
> lock, I think.  Unless there is another locking problem I'm not seeing..
> but I think what is in master now has it covered.
>
> Igor, Somnath, does the current strategy make sense?
>
> sage
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

