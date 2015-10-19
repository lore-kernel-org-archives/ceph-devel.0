From: Sage Weil <sweil@redhat.com>
Subject: newstore direction
Date: Mon, 19 Oct 2015 12:49:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbbJSTtD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 19 Oct 2015 15:49:03 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 0C4C91EB2F
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 19:49:03 +0000 (UTC)
Received: from redhat.com ([10.3.112.16])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9JJn19C012832
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 15:49:02 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The current design is based on two simple ideas:

 1) a key/value interface is better way to manage all of our internal 
metadata (object metadata, attrs, layout, collection membership, 
write-ahead logging, overlay data, etc.)

 2) a file system is well suited for storage object data (as files).

So far 1 is working out well, but I'm questioning the wisdom of #2.  A few 
things:

 - We currently write the data to the file, fsync, then commit the kv 
transaction.  That's at least 3 IOs: one for the data, one for the fs 
journal, one for the kv txn to commit (at least once my rocksdb changes 
land... the kv commit is currently 2-3).  So two people are managing 
metadata, here: the fs managing the file metadata (with its own 
journal) and the kv backend (with its journal).

 - On read we have to open files by name, which means traversing the fs 
namespace.  Newstore tries to keep it as flat and simple as possible, but 
at a minimum it is a couple btree lookups.  We'd love to use open by 
handle (which would reduce this to 1 btree traversal), but running 
the daemon as ceph and not root makes that hard...

 - ...and file systems insist on updating mtime on writes, even when it is 
a overwrite with no allocation changes.  (We don't care about mtime.)  
O_NOCMTIME patches exist but it is hard to get these past the kernel 
brainfreeze.

 - XFS is (probably) never going going to give us data checksums, which we 
want desperately.

But what's the alternative?  My thought is to just bite the bullet and 
consume a raw block device directly.  Write an allocator, hopefully keep 
it pretty simple, and manage it in kv store along with all of our other 
metadata.

Wins:

 - 2 IOs for most: one to write the data to unused space in the block 
device, one to commit our transaction (vs 4+ before).  For overwrites, 
we'd have one io to do our write-ahead log (kv journal), then do 
the overwrite async (vs 4+ before).

 - No concern about mtime getting in the way

 - Faster reads (no fs lookup)

 - Similarly sized metadata for most objects.  If we assume most objects 
are not fragmented, then the metadata to store the block offsets is about 
the same size as the metadata to store the filenames we have now. 

Problems:

 - We have to size the kv backend storage (probably still an XFS 
partition) vs the block storage.  Maybe we do this anyway (put metadata on 
SSD!) so it won't matter.  But what happens when we are storing gobs of 
rgw index data or cephfs metadata?  Suddenly we are pulling storage out of 
a different pool and those aren't currently fungible.

 - We have to write and maintain an allocator.  I'm still optimistic this 
can be reasonbly simple, especially for the flash case (where 
fragmentation isn't such an issue as long as our blocks are reasonbly 
sized).  For disk we may beed to be moderately clever.

 - We'll need a fsck to ensure our internal metadata is consistent.  The 
good news is it'll just need to validate what we have stored in the kv 
store.

Other thoughts:

 - We might want to consider whether dm-thin or bcache or other block 
layers might help us with elasticity of file vs block areas.

 - Rocksdb can push colder data to a second directory, so we could have a 
fast ssd primary area (for wal and most metadata) and a second hdd 
directory for stuff it has to push off.  Then have a conservative amount 
of file space on the hdd.  If our block fills up, use the existing file 
mechanism to put data there too.  (But then we have to maintain both the 
current kv + file approach and not go all-in on kv + block.)

Thoughts?
sage
