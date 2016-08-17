From: Sage Weil <sweil@redhat.com>
Subject: bluestore blobs
Date: Wed, 17 Aug 2016 14:26:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608171407220.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51894 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbcHQO0D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Aug 2016 10:26:03 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59F1783F47
	for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2016 14:26:02 +0000 (UTC)
Received: from ovpn-112-26.phx2.redhat.com (ovpn-112-26.phx2.redhat.com [10.3.112.26])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7HEQ07Q031993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2016 10:26:01 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I think we need to look at other changes in addition to the encoding 
performance improvements.  Even if they end up being good enough, these 
changes are somewhat orthogonal and at least one of them should give us 
something that is even faster.

1. I mentioned this before, but we should keep the encoding 
bluestore_blob_t around when we load the blob map.  If it's not changed, 
don't reencode it.  There are no blockers for implementing this currently.  
It may be difficult to ensure the blobs are properly marked dirty... I'll 
see if we can use proper accessors for the blob to enforce this at compile 
time.  We should do that anyway.

2. This turns the blob Put into rocksdb into two memcpy stages: one to 
assemble the bufferlist (lots of bufferptrs to each untouched blob) 
into a single rocksdb::Slice, and another memcpy somewhere inside 
rocksdb to copy this into the write buffer.  We could extend the 
rocksdb interface to take an iovec so that the first memcpy isn't needed 
(and rocksdb will instead iterate over our buffers and copy them directly 
into its write buffer).  This is probably a pretty small piece of the 
overall time... should verify with a profiler before investing too much 
effort here.

3. Even if we do the above, we're still setting a big (~4k or more?) key 
into rocksdb every time we touch an object, even when a tiny amount of 
metadata is getting changed.  This is a consequence of embedding all of 
the blobs into the onode (or bnode).  That seemed like a good idea early 
on when they were tiny (i.e., just an extent), but now I'm not so sure.  I 
see a couple of different options:

a) Store each blob as ($onode_key+$blobid).  When we load the onode, load 
the blobs too.  They will hopefully be sequential in rocksdb (or 
definitely sequential in zs).  Probably go back to using an iterator.

b) Go all in on the "bnode" like concept.  Assign blob ids so that they 
are unique for any given hash value.  Then store the blobs as 
$shard.$poolid.$hash.$blobid (i.e., where the bnode is now).  Then when 
clone happens there is no onode->bnode migration magic happening--we've 
already committed to storing blobs in separate keys.  When we load the 
onode, keep the conditional bnode loading we already have.. but when the 
bnode is loaded load up all the blobs for the hash key.  (Okay, we could 
fault in blobs individually, but that code will be more complicated.)

In both these cases, a write will dirty the onode (which is back to being 
pretty small.. just xattrs and the lextent map) and 1-3 blobs (also now 
small keys).  Updates will generate much lower metadata write traffic, 
which'll reduce media wear and compaction overhead.  The cost is that 
operations (e.g., reads) that have to fault in an onode are now fetching 
several nearby keys instead of a single key.


#1 and #2 are completely orthogonal to any encoding efficiency 
improvements we make.  And #1 is simple... I plan to implement this 
shortly.

#3 is balancing (re)encoding efficiency against the cost of separate keys, 
and that tradeoff will change as encoding efficiency changes, so it'll be 
difficult to properly evaluate without knowing where we'll land with the 
(re)encode times.  I think it's a design decision made early on that is 
worth revisiting, though!

sage
